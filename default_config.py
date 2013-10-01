#!/usr/bin/env python

config = {
    "theme": "ocean",
    "arrowType": "starfish",
    "appID": "cnl",
    "maxFriendsPerCategory": 20,
    "categories": [
        {
            "id": "family",
            "title": "Family",
            "help": [
                        "Please enter the names of your family members who you know personally and would like to continue to have a personal relationship with.",
                        "If two or more people in your life have the same name, be sure to add a last initial so you don't get them mixed up.",
                        "Click on a name if you need to remove it from the list."
                    ]
        },
        {
            "id": "calling",
            "title": "Calling",
            "help": [
                        "Please take out your phone and look at the voice call log.",
                        "Enter the names of everyone you know personally who you have called or received a call from in the last week.",
                        "If two or more people in your life have the same name, be sure to add a last initial so you don't get them mixed up.",
                        "Click on a name if you need to remove it from the list."
                    ]
        },
        {
            "id": "texting",
            "title": "Texting",
            "help": [
                        "Please take out your phone and look at the texting (SMS) log.",
                        "Enter the names of everyone you know personally who you have sent a text or have received a text from in the last week.",
                        "If two or more people in your life have the same name, be sure to add a last initial so you don't get them mixed up.",
                        "Click on a name if you need to remove it from the list."                                
                        ]
        },
        {
            "id": "facebook",
            "title": "Facebook",
            "help": [
                        "If you opted to authorize Friendly Island to access your Facebook account, here are the names of the most recent people you've interacted with in the last week.",
                        "Otherwise, please enter the names of everyone you have interacted with in the last week.",
                        "If two or more people in your life have the same name, be sure to add a last initial so you don't get them mixed up.",
                        "Click on a name if you need to remove it from the list."                                
                        ]
        }
    ],
    "components":[
        {
            "id": "matching",
            "title": "Matching",
            "help": [
                        "Ok, time to disembark. However, before getting off the ship, we need to get an accurate head count. We know that sometimes you communicate with the same person via multiple channels. For example, maybe you text your mother and talk to her on the phone.",
                        "Please carefully go over this list and find any matches. To do so, highlight each name that you want to merge into a single friend by clicking on it. When you've highlighted some duplicates, click the 'Next Friend' button at the top of the screen. Your merged friend will appear bolded below.",
                        "If you make a mistake, simply double-click the merged friend to remove the names under it. Or if you forget who you have merged, hover over a bolded name to see everyone inside it."
                    ]
        },
        {
            "id": "closeness",
            "title": "Closeness",
            "help": [
                        "Please rate how emotionally close you are with each person by dragging their name into the circle.",
                        "You can rate them from not at all close (perimeter) to extremely close (center)."
                    ]
        },
        {
            "id": "survey",
            "title": "Describe",
            "help": [
                        "Please respond to the following question for each person."
                    ],
            "surveys":[
                    {
                    "question": "When was the last time you saw each person?",
                    "responses": [
                                        {
                                            "text": "Within the last week",
                                            "value": "week"
                                            },
                                        {
                                            "text": "More than a week ago but within the last month",
                                            "value": "month"
                                            },
                                        {
                                            "text": "More than a month ago but within the last year",
                                            "value": "year"
                                            },
                                        {
                                            "text": "More than a year ago",
                                            "value": "overayear"
                                        }

                                    ],
                    "key": "lastSeen"
                    },
                    {
                    "question": "Which of your friends smokes?",
                    "responses": [
                                        {
                                            "text": "Yes",
                                            "value": "yes"
                                            },
                                        {
                                            "text": "No",
                                            "value": "no"
                                            },
                                        {
                                            "text": "Don't know",
                                            "value": "unknown"
                                            }
                                    ],
                    "key": "smoke"
                    }                
            ]
        },
        {
            "id": "circles",
            "title": "Groups",
            "help": [
                        "Now it's time to find groups of friends who all know each other, such as friends from work, school, or a soccer team. Be sure that all group members know each other.",
                        "To create a circle, click on at least 2 names, then type a name for the it into the input field and press enter. To remove a circle, click the 'x' in its title bar.",
                        "To add or remove a person from a circle, first activate the circle by clicking on it, then click on any names in the list above that you wish to add or remove.",
                        "The more groups you can come up with, the more time you'll save"
                    ]
        },
        {
            "id": "friendOfFriend",
            "title": "Friends of Friends",
            "help": [
                        "Finally, put your friends who know each other together in the same place. For each friend select all of the people they know by clicking on their names on the left side. If you make a mistake, you can click the bubble to return them to the other side."
                    ]
        }
    ]
}