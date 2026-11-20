-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function formatProdErrorMessage(arg1, ...): string
    local str1 = "https://reactjs.org/docs/error-decoder.html?invariant=" .. tostring(arg1)
    local select2 = select

    for i = 1, select2("#", ...) do
        str1 ..= "&args[]=" .. HttpService:UrlEncode(select(i, ...))
    end
    return string.format(
        "Minified React error #%d; visit %s for the full message or use the non-minified dev environment for full errors and additional helpful warnings.",
        arg1,
        str1
    )
end

return formatProdErrorMessage
