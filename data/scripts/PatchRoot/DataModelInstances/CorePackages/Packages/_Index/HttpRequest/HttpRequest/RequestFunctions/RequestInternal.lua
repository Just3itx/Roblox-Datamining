-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local getHeaders = require(script.Parent.Util.getHeaders)
local getPostBody = require(script.Parent.Util.getPostBody)

return function(url, method, arg1): Instance
    return HttpService:RequestInternal({
        Url = url,
        Method = method,
        Body = getPostBody(arg1.postBody, method),
        Timeout = arg1.timeout or 15000,
        CachePolicy = arg1.cachePolicy or Enum.HttpCachePolicy.None,
        Priority = arg1.priority or 0,
        Headers = getHeaders(arg1.headers, method),
        RequestType = arg1.requestType or nil,
        AllowSandboxing = arg1.allowSandboxing or nil
    })
end
