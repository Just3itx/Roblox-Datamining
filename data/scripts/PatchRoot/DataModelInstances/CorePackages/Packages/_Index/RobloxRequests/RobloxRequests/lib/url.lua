-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {
    version = "0.9.0",
    options = { separator = "&" },
    services = {
        acap = 674,
        cap = 1026,
        dict = 2628,
        ftp = 21,
        gopher = 70,
        http = 80,
        https = 443,
        iax = 4569,
        icap = 1344,
        imap = 143,
        ipp = 631,
        ldap = 389,
        mtqp = 1038,
        mupdate = 3905,
        news = 2009,
        nfs = 2049,
        nntp = 119,
        rtsp = 554,
        sip = 5060,
        snmp = 161,
        telnet = 23,
        tftp = 69,
        vemmi = 575,
        afs = 1483,
        jms = 5673,
        rsync = 873,
        prospero = 191,
        videotex = 516
    }
}

local tbl1 = {
    ["-"] = true,
    _ = true,
    ["."] = true,
    ["!"] = true,
    ["~"] = true,
    ["*"] = true,
    ["'"] = true,
    ["("] = true,
    [")"] = true,
    [":"] = true,
    ["@"] = true,
    ["&"] = true,
    ["="] = true,
    ["+"] = true,
    ["$"] = true,
    [","] = true,
    [";"] = true
}

local function decode(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 5 call sites recovered
    if not bool1 then
        arg1 = arg1:gsub("+", " ")
    end
    return (arg1:gsub("%%(%x%x)", function(arg2): string
        return string.char(tonumber(arg2, 16))
    end))
end

local function encode(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return (arg1:gsub("([^A-Za-z0-9%_%.%-%~])", function(arg2): string
        return string.upper(string.format("%%%02x", string.byte(arg2)))
    end))
end

local function encodeValue(arg1) -- Luacid: unused: defined but never referenced
    return encode(arg1):gsub("%%20", "+")
end

local function encodeSegment(arg1)
    return arg1:gsub("([^a-zA-Z0-9])", function(arg2)
        if tbl1[arg2] then
            return arg2
        end

        return (encode(arg2))
    end)
end

local function concat(arg1, arg2)
    return arg1 .. arg2:build()
end

function module.build(arg1)
    local str1 = ""
    if arg1.path then
        local path = arg1.path
        path:gsub("([^/]+)", function(arg2)
            return encodeSegment(arg2)
        end)

        str1 ..= tostring(path)
    end
    if arg1.query then
        local str2 = tostring(arg1.query)
        if str2 ~= "" then
            str1 ..= "?" .. str2
        end
    end
    if arg1.host then
        local host = arg1.host
        if arg1.port and arg1.scheme and module.services[arg1.scheme] ~= arg1.port then
            host ..= ":" .. arg1.port
        end

        local user

        if arg1.user and arg1.user ~= "" then
            user = arg1.user
            if arg1.password then
                user ..= ":" .. arg1.password
            end
        else
            user = nil
        end

        if user and user ~= "" then
            host = user .. "@" .. host
        end
        if host then
            if str1 ~= "" then
                str1 = "//" .. host .. "/" .. str1:gsub("^/+", "")
            else
                str1 = "//" .. host
            end
        end
    end
    if arg1.scheme then
        str1 = arg1.scheme .. ":" .. str1
    end
    if arg1.fragment then
        str1 ..= "#" .. arg1.fragment
    end
    return str1
end

function module.buildQuery(arg1, arg2, arg3): string
    local tbl2 = {}
    arg2 = arg2 or module.options.separator or "&"

    local tbl3 = {}
    for k in pairs(arg1) do
        tbl3[#tbl3 + 1] = k
    end
    table.sort(tbl3)
    for _, value in ipairs(tbl3) do
        local var1 = arg1[value]
        local var2 = encode(tostring(value))
        if arg3 then
            var2 = string.format("%s[%s]", tostring(arg3), tostring(var2))
        end
        if type(var1) == "table" then
            tbl2[#tbl2 + 1] = module.buildQuery(var1, arg2, var2)
        else
            local var3 = encode(tostring(var1)):gsub("%%20", "+")
            if var3 ~= "" then
                tbl2[#tbl2 + 1] = string.format("%s=%s", var2, var3)
            else
                tbl2[#tbl2 + 1] = var2
            end
        end
    end
    return table.concat(tbl2, arg2)
end

function module.parseQuery(arg1, arg2)
    arg2 = arg2 or module.options.separator or "&"

    local result = ({})
    for value, value2 in arg1:gmatch(string.format("([^%q=]+)(=*[^%q=]*)", arg2, arg2)) do
        local tbl2 = {}

        local var1 = decode(value, false):gsub("%[([^%]]*)%]", function(arg3): string
            if string.find(arg3, "^-?%d+$") then
                arg3 = tonumber(arg3)
            else
                arg3 = decode(arg3, false)
            end

            table.insert(tbl2, arg3)
            return "="
        end):gsub("=+.*$", ""):gsub("%s", "_")
        local var2 = value2:gsub("^=+", "")

        if not result[var1] then
            result[var1] = {}
        end
        if #tbl2 > 0 and type(result[var1]) ~= "table" then
            result[var1] = {}
        elseif #tbl2 == 0 and type(result[var1]) == "table" then
            result[var1] = decode(var2, false)
        end

        local var3 = result[var1]
        for i, value3 in ipairs(tbl2) do
            local var4 = type(var3) ~= "table" and {} or var3

            if value3 == "" then
                value3 = #var4 + 1
            end
            if not var4[value3] then
                var4[value3] = {}
            end
            if i == #tbl2 then
                var4[value3] = decode(var2, false)
            end
            var3 = var4[value3]
        end
    end
    setmetatable(result, { __tostring = module.buildQuery })
    return result
end

function module.setQuery(arg1, arg2)
    if type(arg2) == "table" then
        arg2 = module.buildQuery(arg2)
    end
    arg1.query = module.parseQuery(arg2)
    return arg2
end

function module.setAuthority(arg1, authority)
    arg1.authority = authority
    arg1.port = nil
    arg1.host = nil
    arg1.userinfo = nil
    arg1.user = nil
    arg1.password = nil

    authority = authority:gsub("^([^@]*)@", function(userinfo): string
        arg1.userinfo = userinfo
        return ""
    end):gsub("^%[[^%]]+%]", function(host): string
        arg1.host = host
        return ""
    end):gsub(":([^:]*)$", function(arg3): string
        arg1.port = tonumber(arg3)
        return ""
    end)
    if authority ~= "" and not arg1.host then
        arg1.host = authority:lower()
    end
    if arg1.userinfo then
        arg1.user = arg1.userinfo:gsub(":([^:]*)$", function(password): string
            arg1.password = password
            return ""
        end)
    end

    return authority
end

function module.parse(arg1)
    local result = {}
    module.setAuthority(result, "")
    module.setQuery(result, "")

    result.path = decode(tostring(arg1 or ""):gsub("#(.*)$", function(fragment): string
        result.fragment = fragment
        return ""
    end):gsub("^([%w][%w%+%-%.]*)%:", function(arg2): string
        result.scheme = arg2:lower()
        return ""
    end):gsub("%?(.*)", function(arg2): string
        module.setQuery(result, arg2)
        return ""
    end):gsub("^//([^/]*)", function(arg2): string
        module.setAuthority(result, arg2)
        return ""
    end), true)

    setmetatable(result, { __index = module, __concat = concat, __tostring = module.build })

    return result
end

function module.removeDotSegments(arg1)
    local tbl2 = {}
    if string.len(arg1) == 0 then
        return ""
    end

    local bool1 = false
    local bool2 = string.sub(arg1, 1, 1) == "/"

    if (string.len(arg1) > 1 or bool2 == false) and string.sub(arg1, -1) == "/" then
        bool1 = true
    end

    arg1:gsub("[^/]+", function(arg2)
        table.insert(tbl2, arg2)
    end)
    local tbl3 = ({})
    local num1 = 0

    for _, value in ipairs(tbl2) do
        if value == ".." then
            if num1 > 0 then
                num1 -= 1
            end
        elseif value ~= "." then
            num1 += 1
            tbl3[num1] = value
        end
    end

    local str1 = if #tbl3 > 0 and num1 > 0 then table.concat(tbl3, "/", 1, num1) else ""

    if bool2 then
        str1 = "/" .. str1
    end
    if bool1 then
        str1 ..= "/"
    end
    return str1
end

local function absolutePath(arg1, arg2)
    if string.sub(arg2, 1, 1) == "/" then
        return "/" .. string.gsub(arg2, "^[%./]+", "")
    end

    if arg2 ~= "" then
        arg1 = "/" .. arg1:gsub("[^/]*$", "")
    end
    local var1 = (arg1 .. arg2):gsub("([^/]*%./)", function(arg3)
        return if arg3 == "./" then "" else arg3
    end)
    local var2 = string.gsub(var1, "/%.$", "/")
    local var3 = nil

    while var3 ~= var2 do
        local var4 = string.gsub(var2, "([^/]*/%.%./)", function(arg3): string
            return if arg3 == "../../" then arg3 else ""
        end)

        var3 = var2
        var2 = var4
    end

    local var4 = string.gsub(var2, "([^/]*/%.%.?)$", function(arg3): string
        return if arg3 == "../.." then arg3 else ""
    end)

    local var5 = nil

    while var5 ~= var4 do
        local var6 = string.gsub(var4, "^/?%.%./", "")
        var5 = var4
        var4 = var6
    end
    return "/" .. var4
end

function module.resolve(arg1, arg2)
    if type(arg1) == "string" then
        arg1 = module.parse(arg1)
    end
    if type(arg2) == "string" then
        arg2 = module.parse(arg2)
    end
    if arg2.scheme then
        return arg2
    end
    arg2.scheme = arg1.scheme
    if not arg2.authority or arg2.authority == "" then
        arg2:setAuthority(arg1.authority)
        if not arg2.path or arg2.path == "" then
            arg2.path = arg1.path
            local query = arg2.query
            if not (query and next(query)) then
                arg2.query = arg1.query
                return arg2
            end
        else
            arg2.path = absolutePath(arg1.path, arg2.path)
        end
    end
    return arg2
end

function module.normalize(arg1)
    if type(arg1) == "string" then
        arg1 = module.parse(arg1)
    end
    if arg1.path then
        local path = arg1.path
        local var1 = absolutePath(path, "")

        arg1.path = string.gsub(var1, "//+", "/")
    end
    return arg1
end

return module
