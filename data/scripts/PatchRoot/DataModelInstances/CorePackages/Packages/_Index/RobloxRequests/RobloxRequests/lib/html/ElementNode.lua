-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
tbl1.mt = { __index = tbl1 }

function tbl1.new(_, arg1)
    local tbl2 = ({})

    local var1 = getmetatable(arg1) == tbl1.mt or nil

    if type(arg1) ~= "table" then
        tbl2 = arg1 ~= nil and {
            [arg1] = true
        } or tbl2
    elseif not var1 and #arg1 > 0 then
        for _, value in ipairs(arg1) do
            tbl2[value] = true
        end
    else
        for k in pairs(arg1) do
            tbl2[k] = true
        end
    end

    return (setmetatable(tbl2, tbl1.mt))
end

function tbl1.add(arg1, arg2)
    if arg2 ~= nil then
        arg1[arg2] = true
    end
    return arg1
end

function tbl1.remove(arg1, arg2)
    if arg2 ~= nil then
        arg1[arg2] = nil
    end
    return arg1
end

function tbl1.tolist(arg1)
    local result = {}
    for k in pairs(arg1) do
        table.insert(result, k)
    end

    return result
end

tbl1.to_list = tbl1.tolist

function tbl1.mt.__add(arg1, arg2)
    local var1 = tbl1:new()
    local var2 = tbl1:new(arg1)
    local var3 = tbl1:new(arg2)
    for k in pairs(var2) do
        var1[k] = true
    end

    for k in pairs(var3) do
        var1[k] = true
    end

    return var1
end

function tbl1.mt.__sub(arg1, arg2)
    local var1 = tbl1:new()
    local var2 = tbl1:new(arg1)
    local var3 = tbl1:new(arg2)
    for k in pairs(var2) do
        var1[k] = true
    end

    for k in pairs(var3) do
        var1[k] = nil
    end

    return var1
end

function tbl1.mt.__mul(arg1, arg2)
    local var1 = tbl1:new()
    local var2 = tbl1:new(arg1)
    local var3 = tbl1:new(arg2)
    for k in pairs(var2) do
        var1[k] = var3[k]
    end

    return var1
end

function tbl1.mt.__tostring(arg1): string
    local str1 = "{"
    local str2 = ""
    for k in pairs(arg1) do
        str1 ..= str2 .. tostring(k)
        str2 = ", "
    end

    return str1 .. "}"
end

local module = {}
module.mt = { __index = module }
function module.new(_, index, arg1, parent, arg3, arg4, arg5)
    local root = {
        index = index,
        name = arg1,
        level = 0,
        parent = nil,
        root = nil,
        nodes = {},
        _openstart = arg4,
        _openend = arg5,
        _closestart = arg4,
        _closeend = arg5,
        attributes = {},
        id = nil,
        classes = {},
        deepernodes = tbl1:new(),
        deeperelements = {},
        deeperattributes = {},
        deeperids = {},
        deeperclasses = {}
    }

    root.attrs = root.attributes
    root.children = root.nodes
    root.descendants = root.deepernodes
    root.descendant_elements = root.deeperelements
    root.descendant_attrs = root.deeperattributes
    root.descendent_ids = root.deeperids
    root.descendant_classes = root.deeperclasses

    if not parent then
        root.name = "root"
        root.root = root
        root._text = arg1
        local num1 = string.len(arg1)
        root._openstart = 1
        root._openend = num1
        root._closestart = 1
        root._closeend = num1
    elseif arg3 then
        root.root = parent.root
        root.parent = parent
        root.level = parent.level + 1
        table.insert(parent.nodes, root)
    else
        root.root = parent.root
        root.parent = parent.parent or parent
        root.level = parent.level
        table.insert(parent.parent and parent.parent.nodes or parent.nodes, root)
    end
    return (setmetatable(root, module.mt))
end

function module.text(arg1): string
    return string.sub(arg1.root._text, arg1._openstart, arg1._closeend)
end
module.gettext = module.text

function module.settext(arg1, _text)
    arg1.root._text = _text
end

function module.textonly(arg1)
    return (arg1:text():gsub("<[^>]*>", ""))
end

function module.content(arg1): string
    return string.sub(arg1.root._text, arg1._openend + 1, arg1._closestart - 1)
end
module.getcontent = module.content

function module.addattribute(arg1, arg2, id)
    arg1.attributes[arg2] = id
    if string.lower(arg2) == "id" then
        arg1.id = id
        return
    end
    if string.lower(arg2) ~= "class" then
        return
    end

    for value in string.gmatch(id, "%S+") do
        table.insert(arg1.classes, value)
    end
end

function module.links(arg1)
    local result = {}

    for _, value in ipairs(arg1:select("a[href]")) do
        if #value.attributes.href > 0 then
            table.insert(result, value.attributes.href)
        end
    end

    return result
end

function module.absolutelinks(arg1, arg2)
    arg2 = (arg2 or arg1.page_url or ""):split("?")[1]:split("#")[1]

    local var1 = arg2:split("://")
    local var2 = var1[#var1]:split("/")[1]
    local var3

    if arg2:find("://") then
        var3 = arg2:split("://")[1]
        var3 = var3 or "http"
    else
        var3 = "http"
    end
    while arg2:sub(-1, -1) == "/" do
        arg2 = arg2:sub(1, -2)
    end

    local result = {}

    for _, value in ipairs(arg1:select("a[href]")) do
        if not (#value.attributes.href > 0) then
            continue
        end

        local href = value.attributes.href

        if not href:find("://") then
            if href:sub(1, 2) == "//" then
                href = var3 .. ":" .. href
            elseif href:sub(1, 1) == "/" then
                href = var3 .. "://" .. var2 .. href
            else
                href = arg2 .. "/" .. href
            end
        end

        table.insert(result, href)
    end

    return result
end

module.absolute_links = module.absolutelinks

local function insert(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 4 call sites recovered
    arg1[arg2] = arg1[arg2] or tbl1:new()
    arg1[arg2]:add(arg3)
end

function module.close(arg1, _closestart, _closeend)
    local var1

    if _closestart and _closeend then
        arg1._closestart = _closestart
        arg1._closeend = _closeend
        var1 = arg1
    else
        var1 = arg1
    end

    while true do
        arg1 = arg1.parent
        if not arg1 then
            break
        end

        arg1.deepernodes:add(var1)
        insert(arg1.deeperelements, var1.name, var1)
        for k in pairs(var1.attributes) do
            insert(arg1.deeperattributes, k, var1)
        end
        if var1.id then
            insert(arg1.deeperids, var1.id, var1)
        end

        for _, value in ipairs(var1.classes) do
            insert(arg1.deeperclasses, value, var1)
        end
    end
end

local function escape(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return string.gsub(str1, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
end

local function select(arg1, arg2)
    if not arg2 or type(arg2) ~= "string" or arg2 == "" then
        return tbl1:new()
    end

    local tbl2 = {
        [""] = arg1.deeperelements,
        ["["] = arg1.deeperattributes,
        ["#"] = arg1.deeperids,
        ["."] = arg1.deeperclasses
    }
    local function match(arg3, arg4)
        local var1, var2, var3

        if arg3 == "[" then
            arg4, var1, var2, var3 = string.match(arg4, "([^=|%*~%$!%^]+)([|%*~%$!%^]?)(=?)(.*)")
        else
            var2 = nil
            var3 = nil
            var1 = nil
        end

        local var4 = tbl1:new(tbl2[arg3][arg4])

        if var2 == "=" then
            if #var3 < 2 then
                var3 = "'" .. var3 .. "'"
            end

            local str1 = string.sub(var3, 2, #var3 - 1)
            if var1 == "!" then
                var4 = tbl1:new(arg1.deepernodes)
            end

            for k in pairs(var4) do
                local var5 = k.attributes[arg4]

                if var1 == "" and var5 ~= str1
                    or var1 == "!" and var5 == str1
                    or var1 == "|" and string.match(var5, "^[^-]*") ~= str1
                    or var1 == "*" and string.match(var5, escape(str1)) ~= str1
                then
                    var4:remove(k)
                elseif var1 == "~" then
                    var4:remove(k)
                    for value in string.gmatch(var5, "%S+") do
                        if value == str1 then
                            var4:add(k)
                            break
                        end
                    end
                elseif var1 == "^" and string.match(var5, "^" .. escape(str1)) ~= str1
                    or var1 == "$" and string.match(var5, escape(str1) .. "$") ~= str1
                then
                    var4:remove(k)
                end
            end
        end

        return var4
    end

    local var1, var2, bool1 = tbl1:new({ arg1 })
    for value in string.gmatch(arg2, "%S+") do
        if value == ">" then
            bool1 = true
        else
            var2 = tbl1:new()
            for k in pairs(var1) do
                local deepernodes = k.deepernodes
                if bool1 then
                    deepernodes = tbl1:new(k.nodes)
                end
                var2 += deepernodes
            end
            bool1 = false
            if value ~= "*" then
                local var3, var4 = tbl1:new()
                local num1 = 0

                while true do
                    local _, var5, var6, var7, var8, var9
                    _, num1, var5, var6, var7, var8, var9 = string.find(value, "(%(?%)?)([:%[#.]?)([%w-_\\]+)([|%*~%$!%^]?=?)(['\"]?)", num1 + 1)

                    if not var7 then
                        break
                    end

                    if var6 == ":" then
                        var4 = var7
                    else
                        if var5 == ")" then
                            var4 = nil
                        end

                        if var6 == "[" and var9 ~= "" then
                            local _, var10
                            _, num1, var10 = string.find(value, "(%b" .. var9 .. var9 .. ")]", num1)

                            var7 ..= var8 .. var10
                        end
                        local var10 = match(var6, var7)
                        if var4 == "not" then
                            var3 += var10
                        else
                            var2 *= var10
                        end
                    end
                end

                var2 -= var3
                var1 = tbl1:new(var2)
            end
        end
    end

    local var3 = var2:tolist()
    table.sort(var3, function(arg3, arg4): boolean
        return arg3.index < arg4.index
    end)
    return var3
end

function module.select(arg1, arg2)
    return select(arg1, arg2)
end
module.mt.__call = select

return module
