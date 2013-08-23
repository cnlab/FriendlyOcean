var myNetwork = (function() {

var width = 999,
    height = 500;

var color = d3.scale.category20();

var force = d3.layout.force()
    .charge(-600)
    .gravity(.7)
    .linkDistance(90)
    .size([width, height]);
    

var nodes;
var links;

function init( network ) {
	nodes = network.nodes;
	links = network.links;
	
    var indices = {};

    $(nodes).each(function(i, obj){
       indices[obj.id] = i; 
    });

    $(links).each(function(i, obj){
        obj.source = indices[obj.source];
            obj.target = indices[obj.target];
    });
    
}

function draw() {
    var svg = d3.select("#myNetwork").append("svg")
        .attr("width", width)
        .attr("height", height);

    force
        .nodes(nodes)
        .links(links)
        .start();

    var link = svg.selectAll("line.link")
        .data(links)
        .enter().append("line")
        .attr("class", "link")
        .attr("stroke-width", 1)
        .attr("stroke", "#000000");
        
    var node = svg.selectAll(".node")
        .data(nodes)
        .enter().append("g")
        .attr("class", "node")
        .call(force.drag);

    node.append("svg:image")
        .attr("class", "circle")
        .attr("xlink:href", function(){ return "assets/img/" + icons[Math.floor(Math.random() * icons.length)]; })
        .attr("x", "-8px")
        .attr("y", "-8px")
        .attr("width", "25px")
        .attr("height", "25px");

    node.append("text")
        .attr("class", "text")
        .attr("dx", 12)
        .attr("dy", ".35em")
        .attr("font-size", "14px")
        .text(function(d) { return d.name; });

    force.on("tick", function() {
        link.attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });
            
        node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
    })
}


return {
	init: init,
	draw: draw
}

})();