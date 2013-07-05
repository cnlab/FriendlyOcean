

var strength = (function() {

var nodes  = [{name: 'YOU', fixed: true, x: 360, y:360}];
var links = [];

var rings = [50, 100, 140, 180, 220, 260, 300];

function init(names) {


var w = 720,
    h = 720,
    r = 20,
    fill = d3.scale.category20();
    






var scale_text = [ "Not at all close",
 				   "Not close",
				   "Not very close",
				   "Somewhat close",
				   "Close",
				   "Very close",
				   "Extremely close",		   
				  ];


var col = d3.scale.linear().domain([50,275]).range(['red','blue']);



var vis = d3.select(".chart").append("svg:svg")
    .attr("width", w)
    .attr("height", h);
    
var tooltip = d3.select('.chart').append("div")
				.style("position", "absolute")
				.style("visibility", "hidden")
				.text("");
    
    vis.selectAll(".ring")
	.data(rings.reverse()).enter().append("circle")
	.style("class", "ring")
	.style("stroke", "solid 1px")
	.style("fill", col)
	.style("fill-opacity", 0.2)
	.attr("r", function(d) { return d })
	.attr("cx", 360)
	.attr("cy", 360)
	.on("mouseover", function() { return tooltip.style("visibility", "visible") } )
	.on("mousemove", function(d,i) { return tooltip.style("top", (event.pageY-10)+"px").style("left", (event.pageX+10)+"px").text(scale_text[i]); })
	.on("mouseout", function() { return tooltip.style("visibility", "hidden"); })

    

for (var f=1; f<=names.length; f++) {
	nodes.push({name: names[f-1], cnt: f});
	links.push({source: f, target: 0, length:f % 4});
}

var force = d3.layout.force()
    .charge(-60)
    .linkDistance(function(d) { return 330 ; })
    .linkStrength(10)
    .nodes(nodes)
    .links(links)
    .size([w, h])
    .start();

var link = vis.selectAll("line.link")
    .data(links)
  .enter().append("svg:line")
    .style("stroke", "#A0A0A0")
    .attr("x1", function(d) { return d.source.x; })
    .attr("y1", function(d) { return d.source.y; })
    .attr("x2", function(d) { return d.target.x; })
    .attr("y2", function(d) { return d.target.y; });





var node_drag = d3.behavior.drag()
        .on("dragstart", dragstart)
        .on("drag", dragmove)
        .on("dragend", dragend);

    function dragstart(d, i) {
        
        force.stop() // stops the force auto positioning before you start dragging
    
    }

    function dragmove(d, i) {
    	if (i>0) {
        d.px += d3.event.dx;
        d.py += d3.event.dy;
        d.x += d3.event.dx;
        d.y += d3.event.dy; 
        
        tick(); // this is the key to make it work together with updating both px,py,x,y on d !
        }
    }

    function dragend(d, i) {
    
        d.fixed = true; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
        tick();
        force.resume();
    }
    
    
    var node = vis.selectAll(".node")
    .data(nodes)
  	.enter()
 	  .append("svg:text")
 	  .attr("class", function(d,i) { if (i==0) { return "EGO" } else { return "node" }})
 	  .attr("dx", "-1em")
    .attr("dy", "0.2em")
 	  .text(function(d) { return d.name })
    .call(node_drag);
    

    
        force.on("tick", tick);

    function tick() {

    
          node.attr("transform", function(d) { 
          						d.x = Math.max(r, Math.min(w - r, d.x)); 
          						d.y = Math.max(r, Math.min(h - r, d.y)); 
          						d.px=d.x; 
          						d.py=d.y; 
          						return "translate(" + d.x + "," + d.y + ")"; 
          			});

      link.attr("x1", function(d) { return d.source.x; })
          .attr("y1", function(d) { return d.source.y; })
          .attr("x2", function(d) { return d.target.x; })
          .attr("y2", function(d) { return d.target.y; });

    };

}    

function validate() {
		// check that all nodes have been moved inside the circle
		// calculate line length for each link and check less
		// than outer ring
		
		var max_length = 300;
		var not_rated = 0;
		
		for (var i=0; i<links.length; i++) {
			sourceX = links[i].source.x;
			sourceY = links[i].source.y;
			targetX = links[i].target.x;
			targetY = links[i].target.y;
			
			linkLength = Math.sqrt(Math.pow((targetX - sourceX),2) + Math.pow((targetY - sourceY),2));
			
			if (linkLength >= max_length) {
				not_rated++;
			}
			
		}
		
		if (not_rated==0) {
			return true;
		} else {
			return false;
		}
}

function getValues() {
	
	var values=[];
	for (var i=0; i<links.length; i++) {
		sourceX = links[i].source.x;
		sourceY = links[i].source.y;
		targetX = links[i].target.x;
		targetY = links[i].target.y;
			
		linkLength = Math.sqrt(Math.pow((targetX - sourceX),2) + Math.pow((targetY - sourceY),2));
		
		var lastSeen;
		for (var c=0; c<rings.length; c++) {
			if (linkLength < rings[c]) {
				lastSeen=c;
			}
		}
		values.push([lastSeen+1,linkLength])
	}
	
	return values;
}

return {
	init: init,
	nodes: nodes,
	links: links,
	validate: validate,
	values: getValues
}

})();
