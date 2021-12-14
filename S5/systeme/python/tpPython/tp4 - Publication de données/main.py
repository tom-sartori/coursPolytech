from dweet import *
import requests
import random
import time

d = Dweet()

for i in range(10):
    xValue = random.randint(0, 90)
    yValue = random.randint(0, 90)

    data = {
        "mouse_x": xValue,
        "mouse_y": yValue
    }

    Dweet.dweet_by_name(d, 'unusual-shock', data)

    idGForm = '1FAIpQLSe4WzPYqLhSfyRrwQt2r1-gkL71clEvxjueWZu6upE1vDQlNw'

    ifq = 'ifq'
    entryX = 'entry.517615364'
    entryY = 'entry.1281750013'
    submit = 'submit=Submit'

    urlGForm = 'https://docs.google.com/forms/d/e/' + idGForm + '/formResponse?' + \
               ifq + '&' + \
               entryX + '=' + str(xValue) + '&' + \
               entryY + '=' + str(yValue) + '&' + \
               submit

    requests.post(urlGForm)

    time.sleep(2)
