var myNetwork = (function(){
       
        var drag;
        
        var nodes = [],
              links = [],
              indices = {},
              width = 999,
              height = 500,
              r = 15;
        
        var force = d3.layout.force()
            .size([width, height])
            .nodes(nodes)
            .links(links)
            .charge(-100)
            .gravity(.3)
            .linkDistance(300)
            .on("tick", tick);

        var svg = d3.select("#myNetwork").append("svg")
            .attr("width", width)
            .attr("height", height); 
      
        var link = svg.selectAll(".link"),
              node = svg.selectAll(".node");
      
        function init( graph ){
            
            graph.nodes.forEach(function( obj, i ){
                nodes.push({name:obj.name, id:obj.id});
            });

            var indices = {};

            nodes.forEach(function(obj, i){
                indices[obj.id] = i;
            });

            graph.links.forEach(function(obj,i){
                links.push({ source: indices[obj.source], target: indices[obj.target]});
            });
            
            force.start();

            drag = force.drag()
                .on("dragstart", dragstart);
        }

        function tick() {
            link.attr("x1", function(d) { return d.source.x; })
                .attr("y1", function(d) { return d.source.y; })
                .attr("x2", function(d) { return d.target.x; })
                .attr("y2", function(d) { return d.target.y; });

            node.attr("transform", function(d) { 
                d.x = Math.max(r, Math.min(width - r, d.x)); 
                d.y = Math.max(r, Math.min(height - r, d.y)); 
                d.px=d.x; 
                d.py=d.y; 
                return "translate(" + d.x + "," + d.y + ")"; 
            });
        }

        function dragstart(d) {
            d.fixed = true;
        }

        function start() {        

            link = link.data(force.links());
            link.enter().append("line")
                  .attr("class", "link")
                  .attr("stroke-width", 1)
                  .attr("stroke", "#000000");

            node = node.data(force.nodes()).enter().append("svg:g").attr("class", "node").call(drag);
            
            node.append("svg:image")
                .attr("xlink:href", function(){ return "assets/img/ocean/elements/" + icons[Math.floor(Math.random() * icons.length)]; })
                .attr("x", "-8px")
                .attr("y", "-8px")
                .attr("width", "25px")
                .attr("height", "25px");

            node.append("svg:text")
                .attr("class", "text")
                .attr("dx", 12)
                .attr("dy", ".35em")
                .attr("font-size", "14px")
                .text(function(d) { return d.name; });

            force.start();

        }

    return{
        start: start,
        init:init,
        force: force,
        nodes:nodes,
        links:links,
        drag:drag
    }
})();