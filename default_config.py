config = {
    "maxFriendsPerCategory": 40, 
    "description": "ethan = Facebook Only, Closeness, Comparison Survey \r\n\r\n*** TO DO: change to 3 weeks of retrieval, code for which week(s) each person comes from, code for birthdays ***", 
    "created": "11/13/13", 
    "theme": "ocean", 
    "arrowType": "turtle", 
    "timeFrameType": "weeks", 
    "components": [
        {
            "id": "closeness", 
            "help": [
                "Please rate how emotionally close you are with each person by dragging their name into the circle.", 
                "You can rate them from not at all close (perimeter) to extremely close (center)."
            ], 
            "title": "Closeness"
        }, 
        {
            "id": "survey", 
            "surveys": [
                {
                    "question": "How much better or worse does YOUR LIFE seem compared to the lives of the following people you know? My life is... ", 
                    "responses": [
                        {
                            "value": "worse", 
                            "long": "A low worse"
                        }, 
                        {
                            "value": "worse", 
                            "long": "Somewhat worse"
                        }, 
                        {
                            "value": "same", 
                            "long": "A little worse"
                        }, 
                        {
                            "value": "same", 
                            "long": "Same"
                        }, 
                        {
                            "value": "same", 
                            "long": "A little better"
                        }, 
                        {
                            "value": "same", 
                            "long": "Somewhat better"
                        }, 
                        {
                            "value": "better", 
                            "long": "A lot better"
                        }
                    ], 
                    "key": "compare", 
                    "instructions": "Please answer the following question for each person you know."
                }
            ], 
            "help": [
                "Please respond to the following question for each person."
            ], 
            "title": "Describe"
        }
    ], 
    "appID": "ethan", 
    "owner": "FB_study", 
    "timeFrameNum": 3.0, 
    "_id": "ethan", 
    "allowManualFB": False, 
    "categories": [
        {
            "id": "facebook", 
            "help": [
                "Here are the names of the most recent people you've interacted with in the last three weeks.",
		"Please look over them and then you can move on to the next screen." 
            ], 
            "title": "Facebook"
        }
    ]
}
