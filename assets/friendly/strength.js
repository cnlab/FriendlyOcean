
var strength = (function() {


    var rings = [50, 100, 140, 180, 220, 260, 300, 301];
    var w = 760,
        h = 720,
        r = 20,
        col = d3.scale.linear().domain([60,300]).range(['red','blue']),
        pi = Math.PI * 2;

    var nodes  = [{name: 'YOU', fixed: true, x: w/2, y:h/2}];
    var links = [];
    
    function init(names,type) {
        
        var arc = d3.svg.arc()
                             .innerRadius( function(d){ return d == rings[0] ? 0 : d-40; })
                             .outerRadius(function(d){ return d; })
                             .startAngle(0)
                             .endAngle(pi);

	var container = '#closenessChart';
        var scale_text = [ "Not at all close",
                           "Not close",
                           "Not very close",
                           "Somewhat close",
                           "Close",
                           "Very close",
                           "Extremely close",          
                          ];

	if (type=='similarity') {

		for (i in scale_text) {
			scale_text[i] = scale_text[i].replace('close','similar'); 
		}
		container = '#similarityChart';
	}

        var vis = d3.select(container).append("svg:svg")
            .attr("width", w)
            .attr("height", h);

            vis.selectAll(".ring")
                    .data(rings.reverse()).enter().append("circle")
                    .attr({
                                "class": "ring",
                                "id": function(d) { return "ring-"+d; },
                                "r": function(d) { return d===301 ? 300 : d; },
                                "cx":  w/2,
                                "cy": h/2,
                                "stroke": function(d) { return d===301 ? "#ffffff" : col(d); },
                                "stroke-width": "1px",
                                "stroke-opacity": .2,
                                "fill": function(d) { return d===301 ? "" : col(d); },
                                "fill-opacity": function(d) { return d===301 ? 0 : .2; }
                              });

        for (var f=1; f<=names.length; f++) {
            nodes.push({name: names[f-1].name, cnt: f, fnum:names[f-1].fnum});
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
            .attr("y2", function(d) { return d.target.y; })
            .attr("id", function(d){ return d.source.fnum; })
            .style("pointer-events", "none");

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

                var link = links.filter(function(a){ return a.source.fnum === d.fnum; })[0];
                linkLength = Math.sqrt(Math.pow((link.target.x - link.source.x),2) + Math.pow((link.target.y - link.source.y),2));
                for (var c=1; c<rings.length; c++) {
                    if (linkLength < rings[c]) {
                        highlight(rings[c]);
                        var t = d3.selectAll(".node-close").filter(function(b){
                            return b.fnum === d.fnum;
                        });
                        t = t.node();
                        t.textContent = scale_text[c-1];
                    }else if (linkLength > 300){
                        highlight();
                        var t = d3.selectAll(".node-close").filter(function(b){
                                        return b.fnum === d.fnum;
                                    });
                                    t = t.node();
                                    t.textContent = "";
                    }
                }
                tick(); // this is the key to make it work together with updating both px,py,x,y on d !
            }
        }

        function dragend(d, i) {
            highlight(null, true);
            var t = d3.selectAll(".node-close").filter(function(b){
                            return b.fnum === d.fnum;
                        });
                        t = t.node();
                        t.textContent = "";
            d.fixed = true; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
            tick();
            force.resume();
        }
            
        function highlight(circle, transition){
            if (circle){
                highlight();
                var s = ".ring:not(#ring-{num})".supplant({"num": circle});
                var c = "#ring-{num}".supplant({"num": circle});
                s = d3.selectAll(s);
                c = d3.select(c);
                s.attr({
                            "fill": "#c7c7c7",
                            "fill-opacity": 1,
                            "stroke": "#ffffff",
                            "stroke-opacity": 1
                         })
                c.attr("stroke", "#ffffff").attr("stroke-opacity", 1);
            }else if(transition){
                d3.selectAll(".ring").transition().attr({
                                            "fill": col,
                                            "fill-opacity": function(d){ return d===301 ? 0 : .2},
                                            "stroke": col,
                                            "stroke-opacity": .2
                                         });
            }else{
                d3.selectAll(".ring").attr({
                                            "fill": col,
                                            "fill-opacity": function(d){ return d===301 ? 0 : .2},
                                            "stroke": col,
                                            "stroke-opacity": .2
                                         });
            }
        }
        var node = vis.append("svg:g")
                                .selectAll(".node")
                                .data(nodes)
                                .enter()
                                  .append("svg:text")
                                  .attr("class", function(d,i) { if (i==0) { return "EGO" } else { return "node" }})
                                  .attr("text-anchor", "middle")
                                  .style("cursor", "pointer")
                                  .text(function(d) { return d.name })
                                .call(node_drag);

        var nodeC = vis.append("svg:g")
                                .selectAll(".node-close")
                                .data(nodes)
                                .enter()
                                  .append("svg:text")
                                  .attr("class", function(d,i) { if (i==0) { return "" } else { return "node-close" }})
                                  .attr("text-anchor", "middle")
                                  .style("cursor", "pointer")
                                  .text("")
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

        nodeC.attr("transform", function(d) { 
            d.x = Math.max(r, Math.min(w - r, d.x)); 
            d.y = Math.max(r, Math.min(h - r, d.y)); 
            d.px=d.x; 
            d.py=d.y; 
            return "translate(" + d.x + "," + (d.y-20) + ")"; 
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
            for (var c=1; c<rings.length; c++) {
                if (linkLength < rings[c]) {
                    lastSeen=c;
                }
            }
            values.push([lastSeen,linkLength])
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
