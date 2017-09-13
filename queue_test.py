from redis import Redis
from rq import Queue

import sys

import fbminer_dp as fbm

q = Queue(connection=Redis())


uid = sys.argv[1]

q.enqueue(fbm.main, uid, timeout=17200)

