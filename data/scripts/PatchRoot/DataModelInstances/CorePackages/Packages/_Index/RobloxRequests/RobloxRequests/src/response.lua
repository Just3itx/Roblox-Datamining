-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local lib = scriptParentParent.lib
local src = scriptParentParent.src

local nocasetable = require(lib.nocasetable)
local html = require(lib.html)

local json = require(src.json)
local cookies = require(src.cookies)

local tbl1 = { "text/html", "application/xhtml+xml" }

local module = {}
module.__index = module
function module.new(request, arg1, responseTime)
    local self = setmetatable({}, module)

    self.request = request

    self.response_time = responseTime
    self.timestamp = self.request.timestamp

    self.url = request.url
    self.method = request.method

    self.code = arg1.StatusCode
    self.status_code = arg1.StatusCode

    self.success = arg1.Success
    self.ok = self.status_code >= 200 and self.status_code < 300

    self.message = arg1.StatusMessage
    self.headers = nocasetable(arg1.Headers)

    self.content = arg1.Body
    self.text = arg1.Body

    self.headers["content-type"] = self.headers["content-type"] or "text/plain"

    self.from_cache = false

    local var1 = self.headers["content-type"]:split(";")
    self.content_type = var1[1]:lower()
    self.encoding = var1[2] and var1[2]:split("=")[2] or ""

    self.content_length = #self.text

    self.cookies = cookies.new()

    if self.headers["set-cookie"] then
        self.cookies:SetCookie(self.headers["set-cookie"])
    end

    return self
end

function module.expand(_) end

function module:__tostring()
    return self.text
end

function module:json()
    local success, result = pcall(function()
        return json.dec(self.text)
    end)

    if not success then
        error(("[http] Failed to convert response content to JSON:\n%s"):format(self.text))
    end

    return result
end

function module:html(arg1)
    if arg1 or table.find(tbl1, self.content_type) then
        return html.parse(self.text, 100000, tostring(self.url))
    end
    error("[http] Response is not specified as HTML.")
end

function module:xml(arg1)
    if arg1 or self.content_type:find("+xml") or self.content_type:find("/xml") then
        return html.parse(self.text, 100000)
    end
    error("[http] Response is not specified as XML.")
end

return module
