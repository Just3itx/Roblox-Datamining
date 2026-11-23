-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function defaultDependencies()
    local Players = game:GetService("Players")
    return {
        gameId = game.GameId,
        root = game,
        players = Players,
        localPlayer = Players.LocalPlayer,
        getService = function(name: string)
            local success, result = pcall(game.GetService, game, name)
            if success then
                return result
            end
            return game:FindFirstChild(name)
        end,
        getReflectionProperties = function(className: string)
            return game:GetService("ReflectionService"):GetPropertiesOfClass(className, {})
        end
    }
end

local function safeGetChildren(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local success, result = pcall(arg1.GetChildren, arg1)
    return if success and typeof(result) == "table" then result else {}
end

local function escapePathSegment(name: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if name == "" then
        return "%00"
    end
    return name:gsub("%%", "%%25"):gsub("%.", "%%2E"):gsub("%[", "%%5B"):gsub("%]", "%%5D")
end

local function unescapePathSegment(str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if str1 == "%00" then
        return ""
    end
    return str1:gsub("%%2E", "."):gsub("%%5B", "["):gsub("%%5D", "]"):gsub("%%25", "%%")
end

local function getChildPathEntries(arg1)
    local tbl1 = safeGetChildren(arg1)
    local tbl2 = {}
    for _, value in tbl1 do
        tbl2[value.Name] = (tbl2[value.Name] or 0) + 1
    end
    local tbl3 = ({})
    local childPathEntries = {}
    for _, instance in tbl1 do
        local valueName = instance.Name
        local var1 = (tbl3[valueName] or 0) + 1
        tbl3[valueName] = var1
        local str1 = if tbl2[valueName] > 1 then `[{var1}]` else ""
        local var2 = escapePathSegment(valueName)
        table.insert(childPathEntries, { instance = instance, segment = var2 .. str1 })
    end

    return childPathEntries
end

local function formatChildSegment(instance) -- Luacid: Inlined by compiler; 2 call sites recovered
    if instance.Parent ~= nil then
        for _, value in getChildPathEntries(instance.Parent) do
            if value.instance == instance then
                return value.segment
            end
        end
    end
    return escapePathSegment(instance.Name)
end

local function appendPathSegment(str1: string, str2: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    if str1 == "" then
        return str2
    end

    return `{str1}.{str2}`
end

local function splitPath(str1: string)
    local var1 = str1:gsub("^game%.", ""):gsub("^game$", "")
    local result = {}
    for value in string.gmatch(var1, "[^%.]+") do
        if value ~= "" then
            table.insert(result, value)
        end
    end
    return result
end

local function parsePathSegment(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1, var2 = string.match(str1, "^(.*)%[(%d+)%]$")
    return unescapePathSegment(var1 or str1), tonumber(var2) or 1
end

local function findChild(arg1, name: string, num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl1 = safeGetChildren(arg1)
    local num2 = 0

    for _, value in tbl1 do
        if value.Name ~= name then
            continue
        end

        num2 += 1
        if num2 == num1 then
            return value
        end
    end

    return nil
end

local function resolvePath(str1: string?, tbl1)
    if str1 == nil or str1 == "" or string.lower(str1) == "game" then
        return tbl1.root, ""
    end

    local tbl2 = splitPath(str1)
    if #tbl2 == 0 then
        return tbl1.root, ""
    end

    local var1, _ = parsePathSegment(tbl2[1])
    local service = tbl1.getService(var1)
    if service == nil then
        return nil, nil
    end

    local var2 = formatChildSegment(service)

    for i = 2, #tbl2 do
        local var3, num1 = parsePathSegment(tbl2[i])

        if service == tbl1.players and var3 == "LocalPlayer" then
            service = tbl1.localPlayer
        else
            service = findChild(service, var3, num1)
        end

        if service == nil then
            return nil, nil
        end

        if service == tbl1.localPlayer then
            var2 = `{var2}.LocalPlayer`
        else
            var2 = appendPathSegment(var2, (formatChildSegment(service)))
        end
    end

    return service, var2
end

local function getDisplayPath(arg1, tbl1)
    local var1 = arg1
    local tbl2 = {}

    while arg1 ~= nil and arg1 ~= tbl1.root do
        if arg1 == tbl1.localPlayer then
            table.insert(tbl2, 1, "LocalPlayer")
            table.insert(tbl2, 1, "Players")
            return table.concat(tbl2, ".")
        end
        table.insert(tbl2, 1, formatChildSegment(arg1))
        arg1 = arg1.Parent
    end
    if arg1 == tbl1.root then
        return table.concat(tbl2, ".")
    end

    return tostring(var1)
end

local function truncateString(str1: string): string
    if #str1 <= 4096 then
        return str1
    end

    local num1 = 4082

    while num1 > 0 do
        local var1 = string.byte(str1, num1)
        if var1 == nil or var1 < 128 or var1 >= 192 then
            break
        end

        num1 -= 1
    end

    local num2 = 4082
    local var1 = if num1 > 0 then string.byte(str1, num1) else nil

    if var1 ~= nil
        and num1 + (if var1 < 128 then 1 elseif var1 < 224 then 2 elseif var1 < 240 then 3 elseif var1 < 248 then 4 else 1) - 1 > 4082
    then
        num2 = num1 - 1
    end

    return string.sub(str1, 1, math.max(num2, 0)) .. "...<truncated>"
end

local function serializeValue(arg1, tbl1, num1: number?)
    local str1 = typeof(arg1)
    if str1 == "nil" or str1 == "boolean" then
        return arg1
    elseif str1 == "string" then
        return (truncateString(arg1))
    elseif str1 == "number" then
        if arg1 == arg1 and arg1 ~= math.huge and arg1 ~= -math.huge then
            return arg1
        end

        return tostring(arg1)
    elseif str1 == "Instance" then
        return getDisplayPath(arg1, tbl1)
    elseif str1 == "table" then
        local num2 = num1 or 0
        if num2 >= 2 then
            return "<table>"
        end
        local result = {}
        local num3 = 0
        for value, value2 in arg1 do
            num3 += 1
            if num3 > 50 then
                result.__truncated = true
                return result
            end
            result[truncateString(tostring(value))] = serializeValue(value2, tbl1, num2 + 1)
        end
        return result
    else
        local success, result = pcall(tostring, arg1)
        if success then
            return (truncateString(result))
        end

        return `<unserializable {str1}>`
    end
end

local function countDescendants(arg1)
    local num1 = 10000
    local success, result = pcall(arg1.GetChildren, arg1)

    local tbl1 = {}
    local bool1 = false

    for _, value in not success and {} or typeof(result) ~= "table" and {} or result do
        if num1 <= #tbl1 then
            bool1 = true
            break
        end

        table.insert(tbl1, value)
    end

    local num2 = 0

    while true do
        if not (#tbl1 > 0 and num1 > 0) then
            return num2, bool1 or #tbl1 > 0
        end

        local var1 = table.remove(tbl1)
        num2 += 1
        num1 -= 1
        local success2, result2 = pcall(var1.GetChildren, var1)
        for _, value in not success2 and {} or typeof(result2) ~= "table" and {} or result2 do
            if num1 <= #tbl1 then
                bool1 = true
                break
            end

            table.insert(tbl1, value)
        end
    end
end

local function countDescendantsByInstance(instance)
    local tbl1 = {{ instance = instance, expanded = false }}
    local tbl2 = {}
    local bool1 = false
    local tbl3 = {}
    local num1 = 1

    while #tbl1 > 0 do
        local var1 = table.remove(tbl1)
        if var1 == nil then
            break
        end

        if var1.expanded then
            local num2 = 0
            for _, value in tbl3[var1.instance] or {} do
                num2 += 1 + (tbl2[value] or 0)
            end
            tbl2[var1.instance] = num2
        else
            local instance2 = var1.instance
            local success, result = pcall(instance2.GetChildren, instance2)
            local var2 = not success and {} or typeof(result) ~= "table" and {} or result

            tbl3[var1.instance] = var2
            table.insert(tbl1, { instance = var1.instance, expanded = true })

            for i = #var2, 1, -1 do
                if num1 >= 10000 then
                    bool1 = true
                    break
                end

                num1 += 1
                table.insert(tbl1, { instance = var2[i], expanded = false })
            end
        end
    end

    return tbl2, bool1
end

local function summarizeChildren(arg1, str1: string)
    local childPathEntries = getChildPathEntries(arg1)
    local immediateChildren = {}
    for value, value2 in childPathEntries do
        if value > 100 then
            break
        end

        table.insert(
            immediateChildren,
            {
                className = value2.instance.ClassName,
                path = appendPathSegment(str1, value2.segment)
            }
        )
    end
    local totalDescendants, var2 = countDescendants(arg1)
    local truncated = #childPathEntries > #immediateChildren or var2
    return {
        immediateChildren = immediateChildren,
        childrenCount = #childPathEntries,
        totalDescendants = totalDescendants,
        truncated = truncated
    }, truncated
end

local function getPropertyNames(arg1, tbl1)
    local propertyNames = {}
    local tbl2 = ({})

    local function addName(name) -- Luacid: Inlined by compiler; 1 call site recovered
        if typeof(name) == "string" and name ~= "" and not tbl2[name] and #propertyNames < 256 then
            tbl2[name] = true
            table.insert(propertyNames, name)
        end
    end

    for _, value in tbl1.getReflectionProperties(arg1.ClassName) do
        if typeof(value) == "table" then
            addName(value.Name)
        end
    end

    table.sort(propertyNames)
    return propertyNames
end

local function collectProperties(arg1, tbl1)
    local result = ({})
    for _, value in getPropertyNames(arg1, tbl1) do
        local success, result2 = pcall(function()
            return arg1[value]
        end)
        if success and result2 ~= nil then
            result[value] = serializeValue(result2, tbl1)
        end
    end
    return result
end

local function collectAttributes(arg1, tbl1)
    local success, result = pcall(arg1.GetAttributes, arg1)
    if not success or typeof(result) ~= "table" then
        return {}
    end

    local result2 = ({})
    local tbl2 = {}
    for value in result do
        table.insert(tbl2, value)
    end
    table.sort(tbl2)
    for value, value2 in tbl2 do
        if value > 100 then
            break
        end

        local var1 = result[value2]
        result2[value2] = serializeValue(var1, tbl1)
    end
    return result2
end

local function invalidInput(message: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return { status = "invalid_input", message = message }
end

local function notInGame() -- Luacid: Inlined by compiler; 2 call sites recovered
    return { status = "not_in_game", message = "The user is not in the game." }
end

local function notFound(path: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        status = "not_found",
        path = path,
        message = "No instance exists at the requested path."
    }
end

local function getOptionalString(arg1, str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    if typeof(arg1) ~= "table" then
        return nil
    end
    local var1 = arg1[str1]
    return if typeof(var1) == "string" and var1 ~= "" then var1 else nil
end

local function getBoundedInteger(arg1, str1: string, num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if typeof(arg1) ~= "table" or typeof(arg1[str1]) ~= "number" then
        return num1
    end
    return math.clamp(math.floor(arg1[str1]), num2, num3)
end

local function getKeywords(arg1)
    local optionalString = getOptionalString(arg1, "keywords")

    if optionalString == nil then
        return {}
    end

    local keywords = {}
    for value in string.gmatch(string.lower(optionalString), "[^,%s]+") do
        table.insert(keywords, value)
    end
    return keywords
end

local function matchesFilters(instance, optionalString: string?, keywords)
    if optionalString ~= nil then
        local success, result = pcall(instance.IsA, instance, optionalString)
        if not (success and result) then
            return false
        end
    end

    local str1 = string.lower(instance.Name)
    for _, keyword in keywords do
        if not string.find(str1, keyword, 1, true) then
            return false
        end
    end
    return true
end

local function makeSearchMatch(_instance, path: string)
    local _instanceParent = _instance.Parent
    local tbl1 = {
        _instance = _instance,
        name = _instance.Name,
        className = _instance.ClassName,
        path = path,
        parentName = if _instanceParent == nil then nil else _instanceParent.Name,
        childrenCount = 0
    }
    local success, result = pcall(_instance.GetChildren, _instance)
    tbl1.childrenCount = #(not success and {} or typeof(result) ~= "table" and {} or result)
    return tbl1
end

return {
    NOT_IN_GAME_MESSAGE = "The user is not in the game.",
    NOT_FOUND_MESSAGE = "No instance exists at the requested path.",
    getInstancePath = function(arg1, tbl1): string
        return getDisplayPath(arg1, tbl1 or defaultDependencies())
    end,
    resolveInstancePath = function(str1: string, className: string, tbl1)
        local var1, var2 = resolvePath(str1, tbl1 or defaultDependencies())
        return if var1 == nil or var1.ClassName ~= className then nil else var2
    end,
    searchClientDataModel = function(arg1, tbl1)
        local var1 = tbl1 or defaultDependencies()
        if var1.gameId == 0 then
            return notInGame()
        end

        local optionalString = getOptionalString(arg1, "path")
        local instance, path = resolvePath(optionalString, var1)
        if instance == nil or path == nil then
            return notFound(optionalString or "")
        end

        local boundedInteger = getBoundedInteger(arg1, "max_depth", 3, 0, 10)
        local boundedInteger2 = getBoundedInteger(arg1, "head_limit", 200, 1, 200)
        local optionalString2 = getOptionalString(arg1, "instance_type")
        local keywords = getKeywords(arg1)

        local tbl2 = {}
        if path == "" then
            for _, value in getChildPathEntries(instance) do
                table.insert(tbl2, { instance = value.instance, path = value.segment, depth = 1 })
            end
        else
            table.insert(tbl2, { instance = instance, path = path, depth = 0 })
        end

        local num1 = 1
        local num2 = 0
        local matches = {}
        local bool1 = false
        local num3 = 0

        while num1 <= #tbl2 do
            if num2 >= 10000 then
                bool1 = true
                break
            end

            local var4 = tbl2[num1]
            num1 += 1
            num2 += 1

            if matchesFilters(var4.instance, optionalString2, keywords) then
                num3 += 1
                if #matches < boundedInteger2 then
                    table.insert(matches, (makeSearchMatch(var4.instance, var4.path)))
                else
                    bool1 = true
                end
            end

            if not (var4.depth < boundedInteger) then
                continue
            end

            for _, value in getChildPathEntries(var4.instance) do
                if num2 + (#tbl2 - num1 + 1) >= 10000 then
                    bool1 = true
                    break
                end

                table.insert(
                    tbl2,
                    {
                        instance = value.instance,
                        path = appendPathSegment(var4.path, value.segment),
                        depth = var4.depth + 1
                    }
                )
            end
        end

        if #matches > 0 then
            local tbl4, bool2 = countDescendantsByInstance(instance)
            for _, value in matches do
                value.totalDescendants = tbl4[value._instance] or 0
                value._instance = nil
            end

            bool1 = bool1 or bool2
        end

        return {
            status = "ok",
            matches = matches,
            count = #matches,
            totalFound = num3,
            truncated = bool1
        }
    end,
    inspectClientInstance = function(arg1, tbl1)
        local var1 = tbl1 or defaultDependencies()
        if var1.gameId == 0 then
            return notInGame()
        end

        local optionalString = getOptionalString(arg1, "path")

        if optionalString == nil then
            return invalidInput("path is required")
        end

        local var2, path = resolvePath(optionalString, var1)
        if var2 == nil or path == nil then
            return notFound(optionalString)
        end

        local children = summarizeChildren(var2, path)
        return {
            status = "ok",
            instance = {
                name = var2.Name,
                className = var2.ClassName,
                path = path,
                properties = collectProperties(var2, var1),
                attributes = collectAttributes(var2, var1),
                children = children
            }
        }
    end
}
