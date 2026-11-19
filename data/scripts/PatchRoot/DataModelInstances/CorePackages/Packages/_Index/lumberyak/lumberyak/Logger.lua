-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:01:23Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Cryo = require(scriptParentParent.Cryo)

local module = {}
module.__index = module

module.Levels = {
    Error = "Error",
    Warning = "Warning",
    Info = "Info",
    Debug = "Debug",
    Trace = "Trace"
}

local tbl1 = {
    module.Levels.Error,
    module.Levels.Warning,
    module.Levels.Info,
    module.Levels.Debug,
    module.Levels.Trace
}

local tbl2 = ({})
for k, value in pairs(tbl1) do
    tbl2[value] = k
end

function module.Levels.fromString(arg1)
    if type(arg1) ~= "string" then
        return nil
    end
    for _, value in pairs(tbl1) do
        if string.lower(value) == string.lower(arg1) then
            return value
        end
    end
    return nil
end

function module.new(parent, name)
    local tbl3 = {
        name = name,
        sinks = {},
        children = {},
        parent = parent,
        context = {},
        dirty = true,
        active = {},
        cache = {
            sinks = {},
            context = {}
        }
    }

    for k, _ in pairs(module.Levels) do
        if parent then
            tbl3.active[k] = parent.active[k]
        else
            tbl3.active[k] = false
        end
    end

    if parent then
        parent.children[tbl3] = true
    end

    setmetatable(tbl3, module)
    return tbl3
end

local function setActive(arg1, arg2)
    local var1 = tbl2[arg1]
    if not var1 then
        return
    end

    for i = 1, var1 do
        arg2.active[tbl1[i]] = true
    end
    for k, _ in pairs(arg2.children) do
        setActive(arg1, k)
    end
end

local function setDirty(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    arg1.dirty = true
    for k, _ in pairs(arg1.children) do
        setDirty(k)
    end
end

local function updateCache(arg1)
    if not arg1.dirty then
        return
    end

    if not arg1.parent then
        arg1.cache.context = arg1.context
        arg1.cache.sinks = arg1.sinks
        arg1.dirty = false
        return
    end

    updateCache(arg1.parent)

    arg1.cache.context = Cryo.Dictionary.join(arg1.parent.cache.context, arg1.context)
    if arg1.parent.cache.context.prefix and arg1.context.prefix then
        arg1.cache.context.prefix = arg1.parent.cache.context.prefix .. arg1.context.prefix
    end
    arg1.cache.sinks = Cryo.List.join(arg1.parent.cache.sinks, arg1.sinks)
    arg1.dirty = false
end

function module:setParent(parent)
    if self.parent then
        self.parent.children[self] = nil
    end

    updateCache(parent)
    self.parent = parent
    self.parent.children[self] = true

    local num1 = -1
    for _, sink in pairs(parent.cache.sinks) do
        if tbl2[sink.maxLevel] then
            num1 = math.max(num1, tbl2[sink.maxLevel])
        end
    end

    if num1 > -1 then
        setActive(tbl1[num1], self)
    end

    setDirty(self)
end

function module:addSink(arg1)
    setActive(arg1.maxLevel, self)
    table.insert(self.sinks, arg1)
    setDirty(self)
end

function module:setContext(context)
    self.context = context
    setDirty(self)
end

local function log(level, arg1, rawMessage: {any})
    if arg1.dirty then
        updateCache(arg1)
    end

    local tbl3 = {
        level = level,
        rawMessage = rawMessage,
        loggerName = arg1.name
    }

    for k, value in pairs(arg1.cache.context) do
        if type(value) == "function" then
            tbl3[k] = value()
        else
            tbl3[k] = value
        end
    end

    local var1 = if rawMessage.n == 0 then "LUMBERYAK INTERNAL: No log message given" else rawMessage[1]

    if tbl3.prefix then
        var1 = tbl3.prefix .. var1
    end

    if var1:find("{") then
        local num1 = 1
        var1 = var1:gsub("{(.-)}", function(arg2)
            if arg2 ~= "" then
                local var2 = tbl3[arg2]
                return var2 and tostring(var2)
            end

            num1 += 1
            return tostring(rawMessage[num1])
        end)
        if rawMessage.n > num1 then
            var1 ..= "\nLUMBERYAK INTERNAL: Too many arguments given for format string"
        elseif rawMessage.n < num1 then
            var1 ..= "\nLUMBERYAK INTERNAL: Too few arguments given for format string"
        end
    elseif rawMessage.n > 1 then
        var1 ..= "\nLUMBERYAK INTERNAL: Too many arguments given for format string"
    end

    local var2 = tbl2[level]
    for _, sink in pairs(arg1.cache.sinks) do
        if tbl2[sink.maxLevel] and var2 <= tbl2[sink.maxLevel] then
            sink:log(var1, tbl3)
        end
    end
end

function module:error(...)
    if not self.active[module.Levels.Error] then
        return
    end
    log(module.Levels.Error, self, table.pack(...))
end

function module:warning(...)
    if not self.active[module.Levels.Warning] then
        return
    end
    log(module.Levels.Warning, self, table.pack(...))
end

function module:info(...)
    if not self.active[module.Levels.Info] then
        return
    end
    log(module.Levels.Info, self, table.pack(...))
end

function module:debug(...)
    if not self.active[module.Levels.Debug] then
        return
    end
    log(module.Levels.Debug, self, table.pack(...))
end

function module:trace(...)
    if not self.active[module.Levels.Trace] then
        return
    end
    log(module.Levels.Trace, self, table.pack(...))
end

return module
