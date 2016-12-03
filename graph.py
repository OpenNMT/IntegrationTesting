# Code to upload graphs to plotly

import plotly 
import datetime

# Don't steal my account.
plotly.tools.set_credentials_file(username='srush', api_key='UQ8nYG8eVknB63NjMq9k')


import re
import plotly.plotly as py
from plotly.graph_objs import *
import sys

def escape_ansi(line):
    ansi_escape = re.compile(r'(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]')
    return ansi_escape.sub('', line).strip()
def get_lines():
    while True:
        input = ""
        c = sys.stdin.readline()
        if c == "": break
        yield c

ppls = []
xs = []
old = py.get_figure("srush", 1)["data"][-7:]
for l in get_lines():
    q = escape_ansi(l.strip())
    print(q)
    if q.startswith("Epoch"):
        print("Epoch")
    # Epoch 1 ; Batch 50/183 ; LR 1.0000 ; Throughput 1410/518/892 total/src/targ tokens/sec ; PPL 110737.21 ; Free mem 2447245312
        epoch, batch, lr, speed, ppl, mem = q.split(";")
        ppl = float(ppl.split()[1])
        epoch = float(epoch.split()[1])
        batch_term = batch.split()[1].split("/")
        batch = float(batch_term[0]) / float(batch_term[1])
        ppls.append(ppl)
        xs.append(epoch + batch)

trace0 = Scatter(
            x=xs,
            y=ppls,
            name ="Test Run" + str(datetime.date.today()))
data = Data(old + [trace0])
print("Sending Graph Data")
py.plot({"data":data, "layout": {"title":"Performance", 
                                         "xaxis" : {"title": "Epoch"},
                                         "yaxis" : {"title": "ppl"},
                                     }},
                auto_open = False, filename = 'my plot')
