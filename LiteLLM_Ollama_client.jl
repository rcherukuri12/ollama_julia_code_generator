# this program expects on your local machine(mac/linux):
# 1. Ollama already installed.
# 2. Ollama should have downloaded mistral
# 3. The LiteLLM Ollama proxy correctly set with localhost port 8000

using Pkg
Pkg.add("JSON")
Pkg.add("JSON3")
Pkg.add("OpenAI")
using JSON, JSON3, OpenAI
o = OpenAI.OpenAIProvider("junk", "http://localhost:8000", "")

function update_prompt(question)
    data = Dict()
    data["model"]       = "mistral"
    data["prompt"]      = question
    data["stream"]      = false
    data["temperature"] = 0.0
    return JSON.json(data)
end
d = update_prompt("julia code to show today's date, using Dates package")

r = OpenAI.create_chat(o,"ollama/mistral",[Dict("role" => "user", "content" => d)])

if r.status == 200
    println(r.response[:choices][1][:message][:content])
end