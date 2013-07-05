import tps, urllib, cgi, facebook, community, FQL
import datetime


FACEBOOK_APP_ID = "184250398371980"
FACEBOOK_APP_SECRET = "f029f9056c43b453a5e75c594f061e16"
REDIRECT_URI = "http://127.0.0.1:8080"


EXTENDED_PERMS = [
        "user_about_me",
        "friends_about_me",
        "user_activities",
        "friends_activities",
	    "user_birthday",
	    "friends_birthday",
        "user_education_history",
        "friends_education_history",
        "user_events",
        "friends_events",
        "user_groups",
        "friends_groups",
        "user_hometown",
        "friends_hometown",
        "user_interests",
        "friends_interests",
        "user_likes",
        "friends_likes",
        "user_location",
        "friends_location",
        "user_notes",
        "friends_notes",
        "user_photo_video_tags",
        "friends_photo_video_tags",
        "user_photos",
        "friends_photos",
        "user_relationships",
        "friends_relationships",
        "user_status",
        "friends_status",
        "user_videos",
        "friends_videos",
        "read_friendlists",
        "read_requests",
        "read_stream",
        "user_checkins",
        "friends_checkins",
	      "read_mailbox"
]

access_token = "CAACnkyOLcIwBAFJCDJLGqHHZBfsrk1GrE0M9yDXLeyq1SXNMZAjlDIJAHZAQd0JZApyeYrZBc2kZBVrN3TyKAoerfNBCqUKf4HK2we6Lf65jZA3E1G6Pn83LF73LSE23zTNhlAUQDyXBO57hYwfT72fJcUH8ivRTZC3bdgOHbV6rwgZDZD"
graph = facebook.GraphAPI(access_token)

week = datetime.timedelta(weeks=10)
start_date = datetime.datetime.today() - week

friends = tps.get_interactions_from_last(access_token, start_date)

#friends = tps.get_friends(graph, names=True)
print friends