# this program expects on your local machine(mac/linux):
# 1. Ollama already installed.
# 2. Ollama should have downloaded mistral
# 3. The following two packages HTTP & JSON already installed.
# resulting answer :
```julia
using Dates
today()
```
#
#

using HTTP
using JSON

url = "http://localhost:11434/api/generate"

function update_prompt(question)
    data = Dict() # declare empty to support Any type.
    data["model"] = "mistral"
    data["prompt"]= question
    data["stream"]= false  # turning off streaming response.
    data["temperature"] = 0.0
    return JSON.json(data)
end

data = update_prompt("write julia code to find out today's date using Dates package")
res  = HTTP.request("POST",url,[("Content-type","application/json")],data)
if res.status == 200
    body = JSON.parse(String(res.body))
    println(body["response"])
end
