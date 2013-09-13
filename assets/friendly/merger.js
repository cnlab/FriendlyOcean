var merger = (function(){
    var currentSpan;

    function init( names ){
        currentSpan = names[0];
        return currentSpan;
    }

    function nextFriend(){        
        var span = $("#merge .lists-row").find("span").first()[0];
        if ( span ){
            currentSpan = span;
            return currentSpan;
        }else{
            return false;
        }
    }

    //Merge selected friends
    function mergeFriends(){
        var selected = $('.selected');
        var m = $('#merged');
        if (selected.length > 0) {
            
            //Get current span data
            var cData = jQuery.extend(true,{},$(currentSpan).data());
            cData.name = $(currentSpan).text();
            
            var mList = [];
            if( cData.merged ){
                mList = cData.merged;
            }else{
                mList.push(cData);
            }

            $(selected).each( function( i, obj ){
                var data = $(obj).data();
                if ( data.hasOwnProperty('merged')) {
                    $(data.merged).each(function(i,d){
                        mList.push(d);
                    });
                }
                else{
                    var name = $(obj).text();
                    data.name = name;
                    mList.push(data);
                }
            });

            $(currentSpan).data('merged', mList);
            
            //list for popover
            var ul = $("<ul class='unstyled'></ul>");
            $(mList).each( function(i,o){
                if(o.friendNumber != cData.friendNumber){
                    var li = $("<li></li>").text(o.name + " (" +o.catId.split("_")[0]+")").click(function(e){e.stopPropagation();}).appendTo(ul);
                }
            });

            $(currentSpan).addClass("fat");
            $(selected).parent().remove();
            $(currentSpan).on('dblclick', split);
            $(currentSpan).popover({
                html: true,
                trigger: "hover",
                placement: "bottom", 
                title: "Also known as...",
                content:  ul,
                delay: 300
            });

            disembark( $(currentSpan).parent(), "#merged" );
        }
        else {
            disembark( $(currentSpan).parent(), "#merged" );
        }
        
    }

    //Unmerge names
    function split( event ) {
        var element = event.toElement;
        var merged = $(element).data('merged');

        if(merged){
            merged = merged.splice(1)
            $(merged).each(function (i, obj) {
                var friendNumber = obj.friendNumber;
                var name = obj.name;
                var hash = obj.hash;
                var catId = obj.catId;
                var homeList = $("#{cat}-list".supplant({'cat':catId.split('_')[0]}));
                var li = $('<li></li>').attr('onclick', 'select(this)');
                var span = $('<span></span>').data({
                    friendNumber: friendNumber,
                    catId: catId,
                    name: name,
                    hash: hash
                })
                .attr("id", friendNumber+"-merge")
                .text(name);
                li.append(span);
                homeList.append(li);
            });
            $(event.target).removeClass("fat").removeClass("selected").removeData("merged").popover("destroy");
            $('.merge-list li').tsort();
        }
    }

    //Merge friends for good
    function finalMerge(){
        var merged = [];
        var friend_list = $('.merge-list li');
        $(friend_list).each(function( i, li ){
            var span = $(li).children();
            var data = $(span).data();
            if ( data.hasOwnProperty('merged') ) {
                var mainFriend = $(Friendly.friends).filter(function( i ) {
                    return this.friendNumber == data.merged[0].friendNumber;
                })[0];
                
                $(data.merged).each(function(i,obj){
                    if ( obj.friendNumber != mainFriend.friendNumber ){
                        mainFriend.category.push(obj.catId);
                        $(Friendly.friends).each(function(a,b){
                            if (b.friendNumber == obj.friendNumber) {
                                Friendly.friends.splice(a,1);
                            }
                        });
                    }
                });
            }
        });
    }

    //Select all names that can possibly be the same person
    function matchSuspects( name ){
        rgName = name.substring(0,3);
        lcName = name.toLowerCase().substring(0,3);
        var rgQ = "#merge .merge-list span:contains('{str}')".supplant({"str": rgName});
        var lcQ = "#merge .merge-list span:contains('{str}')".supplant({"str": lcName});
        $(rgQ).addClass("selected");
    }

    return {
        init: init,
        matchSuspects: matchSuspects,
        nextFriend: nextFriend,
        mergeFriends: mergeFriends,
        split: split,
        finalMerge: finalMerge
    }

})();