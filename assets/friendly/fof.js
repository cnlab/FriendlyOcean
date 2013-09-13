var fof = (function(){
    
    //Styling for D3 graph
    var nodeHover = "#ff0000",
        lineHover = "#ff7c7c",
        nodeColor = "#e7edfa",
        lineColor = "#c2c2c2",
        centerColor = "#006dcc",
        nodeStroke = "#c2c2c2",
        centerStroke = "#ffffff",
        strokeWidth = "1.5px",
        nodeFontColor = "#000000",
        centerFontColor = "#ffffff",
        centerFontSize = "30px",
        nodeFontSize = "18px";

    var center;
    var currentNode = 0;
    var allNodes=[];
    var allLinks = [];
   
    var width = 592,
        height = 510;

    var nodes = [],
        links = [];

    var force = d3.layout.force()
        .nodes(nodes)
        .links(links)
        .charge(-900)
        .linkDistance(400)
        .gravity(1)
        .size([width, height])
        .on("tick", tick);

    var svg = d3.select("#friendGraph").append("svg")
        .attr("width", width)
        .attr("height", height);

    var node = svg.selectAll(".node"),
        link = svg.selectAll(".link"),
        text = svg.selectAll("text");

    function start() {
      link = link.data(force.links(), function(d) { return d.source.id + "-" + d.target.id; });
      link.enter().insert("line", ".node")
                  .attr({
                      "class": "link",
                      "id": function(d){ return d.source.id + "-" + d.target.id; },
                      "stroke": lineColor,
                      "stroke-width": strokeWidth
                  })
                  .on({
                      "click": function(d){ 
                                   if( d.source.id == center.id ){
                                       removeFriendNode(d.target);
                                   }
                                   else{
                                       removeFriendNode(d.source);
                                   }
                                   d3.select('.center-node').attr({"fill": centerColor});
                               },
                      "mouseover": function(d){
                                       var id = this.id.split("-").filter(function(b,i){ return b!=center.id })[0];
                                       d3.select('.center-node').attr({"fill": nodeHover, "stroke": nodeHover});
                                       d3.select("#"+id).attr({"fill": nodeHover});
                                       d3.select(this).attr({"stroke": lineHover});
                                   
                                   },
                      "mouseout": function(d){
                                      var id = this.id.split("-").filter(function(b,i){ return b!=center.id });
                                      d3.select('.center-node').attr({"fill": centerColor, "stroke": centerStroke});
                                      d3.select("#"+id).attr({"fill": nodeColor});
                                      d3.select(this).attr({"stroke": lineColor});
                                  }
                  });
      link.exit().remove();

      node = node.data(force.nodes(), function(d) { return d.id;});
      node.enter().append("ellipse")
                  .attr({
                      "class": function(d){ return d.id == center.id ? "node center-node" : "node" },
                      "id": function(d){ return d.id; },
                      "ry": 20,
                      "rx": 40,
                      "fill": function(d){ return d.id == center.id ? centerColor : nodeColor },
                      "stroke": function(d){ return d.id == center.id ? centerStroke : nodeStroke },
                      "stroke-width": strokeWidth
                  })
                  .on({
                      "click": function(d){
                                   if( d.id != center.id ){
                                       removeFriendNode(d);
                                       d3.select('.center-node').attr({"fill": centerColor});
                                   }
                               },
                      "mouseover": function(d){ 
                                       if( d.id != center.id ){
                                           d3.select('.center-node').attr({"fill": nodeHover, "stroke": nodeHover});
                                           d3.select(this).attr({"fill": nodeHover});
                                           d3.selectAll('line').filter(function(a){ return (a.source.id == d.id && a.target.id == center.id)  || (a.source.id == center.id && a.target.id == d.id) }).attr({"stroke": lineHover});
                                       }
                                    },
                      "mouseout": function(d){ 
                                       if( d.id != center.id ){
                                           d3.select('.center-node').attr({"fill": centerColor, "stroke": centerStroke});
                                           d3.select(this).attr({"fill": nodeColor});
                                           d3.selectAll('line').filter(function(a){ return (a.source.id == d.id && a.target.id == center.id)  || (a.source.id == center.id && a.target.id == d.id) }).attr({"stroke": lineColor});
                               
                                       }
                                  }
                  });
      node.exit().remove();
      
      text = text.data(force.nodes(), function(d) { return d.name+"-"+d.id; });
      text.enter().append("text")
                  .attr({
                      "text-anchor": "middle",
                      "fill": function(d){ return d.id == center.id ? centerFontColor : nodeFontColor },
                      "font-size": function(d){ return d.id == center.id ? centerFontSize : nodeFontSize },
                      "baseline": "middle",
                      "id": function(d){ return d.id + "-text"; }
                  })
                  .on({
                      "click": function(d){
                                   if( d.id != center.id ){
                                       removeFriendNode(d);
                                       d3.select('.center-node').attr({"fill": centerColor});
                                   }
                               },
                      "mouseover": function(d){ 
                                       if( d.id != center.id ){
                                           d3.select('.center-node').attr({"fill": nodeHover, "stroke": nodeHover});
                                           d3.selectAll('.node').filter(function(n){ return n.id == d.id; }).attr({"fill": nodeHover});
                                           d3.selectAll('line').filter(function(a){ return (a.source.id == d.id && a.target.id == center.id)  || (a.source.id == center.id && a.target.id == d.id) }).attr({"stroke": lineHover});
                                       }
                                    },
                      "mouseout": function(d){ 
                                       if( d.id != center.id ){
                                           d3.select('.center-node').attr({"fill": centerColor, "stroke": centerStroke});
                                           d3.selectAll('.node').filter(function(n){ return n.id == d.id; }).attr({"fill": nodeColor});
                                           d3.selectAll('line').filter(function(a){ return (a.source.id == d.id && a.target.id == center.id)  || (a.source.id == center.id && a.target.id == d.id) }).attr({"stroke": lineColor});
                               
                                       }
                                  }
                  })
                  .text(function(d){ return d.name; });
      text.exit().remove();
      
      force.start();
    }

    function tick() {
      node.attr("cx", function(d) { return d.x = Math.max(this.rx.animVal.value, Math.min(width - this.rx.animVal.value, d.x)); })
          .attr("cy", function(d) { return d.y = Math.max(this.ry.animVal.value, Math.min(height - this.ry.animVal.value, d.y)); })
          .attr("ry", function(d) { return d3.select("#"+d.id+"-text").node().getBBox().height * .7 })
          .attr("rx", function(d) { return d3.select("#"+d.id+"-text").node().getBBox().width * .7 });

      link.attr("x1", function(d) { return d.source.x; })
          .attr("y1", function(d) { return d.source.y; })
          .attr("x2", function(d) { return d.target.x; })
          .attr("y2", function(d) { return d.target.y; });
      
      text.attr("x", function(d) { return d.x; })
          .attr("y", function(d) { return this.id.split("-")[0] == center.id ? d.y + 8 : d.y + 5; });
    }

    function init(nodeList, linkList){
        $(nodeList).each( function( i, obj ){
            var n = {"name": obj.name, "id": obj.friendNumber};
            allNodes.push(n);
        });

        $(linkList).each( function( i, obj ){
            var n = {"source": findFriend(obj.source), "target": findFriend(obj.target)};
            allLinks.push(n);
        });
        return allNodes[currentNode];
    }

    function findFriend( friendNumber ){
        var f = allNodes.filter(function(n){ return n.id == friendNumber})[0];
        return {"name": f.name, "id": f.id};
    }
    
    function buildNodeList(){
        var names = jQuery.map(allNodes, function( obj, i){
                                    return obj.id != center.id ? { "name": obj.name, "id": obj.id } : null;
                              });
                              
        var nodeIds = jQuery.map(nodes, function( obj, i ){
                                    return obj.id != center.id ? obj.id : null;
                                 });
        
        var nodeList = $("<ul></ul>");
        $(names).each( function( i, obj ){
            var li = $("<li></li>");
            var span = $("<span></span>").data('id', obj.id).text(obj.name)
            
            if( jQuery.inArray(obj.id, nodeIds) == -1 ){
                $(span).addClass("node-list-on");
            }
            else{
                $(span).addClass("node-list-off");
            }
                  
            $(span).click(function( event ){
                if( $(this).hasClass('node-list-off') ){
                    event.stopPropagation();
                    event.preventDefault();
                    return;
                }
                fof.addLeaf(obj.id);
                $(this).toggleClass('node-list-off')
                       .toggleClass('node-list-on');
            });
            $(li).append(span).appendTo(nodeList);
            $("#node-list").append(nodeList);
            
        });
        
        $(nodeList).children().tsort();
    }
    
    function addCenterFriend( centerNode ){
        center = centerNode;
        centerNode.fixed = true;
        centerNode.x = width/2;
        centerNode.y = height/2;
        nodes.push(centerNode);
        
        start();
        
        addFriendLinks( centerNode );
        buildNodeList();
    }

    function addLeaf( friendNumber ){
        var f = findFriend( friendNumber );
        nodes.push(f);
        links.push({source: center, target: f});
        allLinks.push({source: {name: center.name, id: center.id}, target: {name: f.name, id: f.id}});
        start();
    }

    function addFriendLinks( centerNode ){
        var l = [];
        $(allLinks).each( function( i, obj ){
            if(obj.source.id === centerNode.id || obj.target.id === centerNode.id){
                l.push({ "source":{"name": obj.source.name, "id": obj.source.id}, "target":{"name": obj.target.name, "id": obj.target.id} });
            }
        });
        $(l).each( function( i, obj ){
            var a;
            if( obj.source.id === centerNode.id){
                a = findFriend(obj.target.id);
            }
            else{
                a = findFriend(obj.source.id);
            }
            nodes.push(a);
            var link = {source: centerNode, target: a};
            links.push(link);
        });
        start();
    }

    function removeFriendNode( friendNode ){
        var nodeIndex = friendNode.index;
        nodes.splice( nodeIndex, 1 );
    
        var link = d3.selectAll('line').filter(function(d){ return (d.source.id == center.id && d.target.id == friendNode.id) || (d.source.id == friendNode.id && d.target.id == center.id)}).datum();
        if( findLinkIndex(link, links) != -1 ){
            links.splice( findLinkIndex(link, links), 1);
        }
        if( findLinkIndex(link, allLinks) != -1 ){
            allLinks.splice( findLinkIndex(link, allLinks), 1);
        }
        start();
        
        $("#node-list span").each(function( i, obj ){
            if( $(obj).data('id') === friendNode.id ){
                $(obj).toggleClass('node-list-off')
                      .toggleClass('node-list-on');
            }
        });
    }

    function findLinkIndex( link, linkArray ){
        var index = -1;
        var ls = link.source.id,
            lt = link.target.id;
    
        $(linkArray).each( function( i, l ){
            if( (l.source.id == ls && l.target.id == lt) || (l.source.id == lt && l.target.id == ls) ){
                index = i;
            }
        });
        return index;
    }
    
    function nextFriend(){
        currentNode++;
        
        $(allNodes).each(function( i, obj ){
            obj = {"name":obj.name, "id": obj.id};
        });
        
        $(allLinks).each(function( i, obj ){
            obj = { "source":{"name": obj.source.name, "id": obj.source.id}, "target":{"name": obj.target.name, "id": obj.target.id} };
        });
        
        $("#node-list ul").remove();
        
        if( currentNode < allNodes.length ){
            //empty arrays for graph and redraw            
            var i = nodes.length;
            while( i > -1 ){
                nodes.pop();
                i--;
            }
            
            var i = links.length;
            while( i > -1 ){
                links.pop();
                i--;
            }
            start();
            
            var nf = allNodes[currentNode];
            addCenterFriend(nf);
            return nf;
        }
        else{
            return false;
        }
    }
    
    function finalizeLinks(){
        
        $(allLinks).each( function( i, obj ){
            Friendly.links.push({source:obj.source.id, target:obj.target.id});
            network.links.push({source:obj.source.id, target:obj.target.id});
        });

        $(allNodes).each( function( i, obj ){
            network.nodes.push({name:obj.name, id:obj.id});
        });
    }
    
    return {
        links: links,
        nodes: nodes,
        init: init,
        addCenterFriend: addCenterFriend,
        addLeaf: addLeaf,
        start: start,
        removeFriendNode: removeFriendNode,
        allLinks: allLinks,
        allNodes: allNodes,
        nextFriend: nextFriend,
        currentNode: currentNode,
        buildNodeList: buildNodeList,
        finalizeLinks: finalizeLinks
    }
})();