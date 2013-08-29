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
            $(selected).parent().remove();
            $(currentSpan).on('dblclick', split);
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
            $(event.target).parent().remove();
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
        var matches = [];
        name = name.toLowerCase().substring(0,3);
        $("#merge .merge-list span").each( function( i, obj ){
            var tmp = $(obj).text().toLowerCase();
            if ( tmp.search( name ) != -1 ){
                $(obj).addClass("selected");
            }
        });
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