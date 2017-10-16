from requests import get
from base64 import b64decode
from pick import pick
from subprocess import call
import json


url = ""
config_file = "/etc/shadowsocks-libev/config.json"


def d(s):
    if isinstance(s, bytes):
        s = s.decode("UTF-8")
    res = b64decode(s.replace("_", "/").replace("-", "+") + "==")
    if isinstance(res, bytes):
        res = res.decode("UTF-8")
    return res


def parse_url(url):
    r = get(url)
    links = d(r.text).split()
    result = []
    for link in links:
        server = d(link[6:len(link)]).split("/?")
        tmp = server[0].split(":")
        res = {}
        res["server"] = tmp[0]
        res["server_port"] = tmp[1]
        res["protocol"] = tmp[2]
        res["method"] = tmp[3]
        res["obfs"] = tmp[4]
        res["password"] = d(tmp[5])
        for param in server[1].split("&"):
            tmp0 = param.split("=")
            res[tmp0[0]] = d(tmp0[1])
        result.append(res)
    return result


def main():
    f = open(config_file, "r")
    print("Current server: {data[remarks]} {data[server]}".format(data = json.loads(f.read())))
    f.close()
    print("Getting server list")
    servers = parse_url(url)
    selected = pick(list(map(lambda line: line["remarks"], servers)))
    print("{} selected".format(selected[0]))
    conf = servers[selected[1]]
    conf["local_port"] = "1080"
    conf["timeout"] = "60"
    if "obfsparam" in conf:
        conf["obfs_param"] = conf.pop("obfsparam")
    f = open(config_file, "w")
    f.write(json.dumps(conf, ensure_ascii=False))
    f.close()
    call(["supervisorctl", "restart", "shadowsocks"])



main()

