-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ErrorReportersParent = script:FindFirstAncestor("ErrorReporters").Parent
local HttpService = game:GetService("HttpService")

local Cryo = require(ErrorReportersParent.Cryo)
local t = require(ErrorReportersParent.t)

local ProcessErrorStack = require(script.Parent.Parent.ProcessErrorStack)

local var1 = t.strictInterface({
    guessed_frame = t.optional(t.boolean),
    funcName = t.optional(t.string),
    address = t.optional(t.string),
    line = t.optional(t.string),
    column = t.optional(t.string),
    sourceCode = t.optional(t.string),
    library = t.optional(t.string),
    debug_identifier = t.optional(t.string),
    faulted = t.optional(t.boolean),
    registers = t.optional(t.map(t.string, t.some(t.string, t.number)))
})

local var2 = t.strictInterface({ name = t.optional(t.string), fault = t.optional(t.boolean), stack = t.optional(t.array(var1)) })

local var3 = t.strictInterface({ name = t.string, registers = t.map(t.string, t.string) })

local var4 = t.strictInterface({
    text = t.optional(t.string),
    startLine = t.optional(t.number),
    startColumn = t.optional(t.number),
    startPos = t.optional(t.number),
    path = t.optional(t.string),
    tabWidth = t.optional(t.number)
})

local var5 = t.strictInterface({ read = t.boolean, write = t.boolean, exec = t.boolean })

local var6 = t.strictInterface(
    {
        start = t.string,
        size = t.optional(t.number),
        data = t.optional(t.string),
        perms = t.optional(var5)
    }
)
local var7 = t.strictInterface({
    start = t.string,
    size = t.number,
    code_file = t.optional(t.string),
    version = t.optional(t.string),
    debug_file = t.optional(t.string),
    debug_identifier = t.optional(t.string),
    debug_file_exists = t.optional(t.boolean)
})

local var8 = t.optional(t.map(t.string, t.some(t.string, t.number, t.boolean)))

local var9 = t.optional(t.map(t.string, function(arg1)
    local function checkTypeRecursive(arg2)
        if type(arg2) ~= "table" then
            return t.some(t.string, t.number, t.boolean)(arg2)
        end

        for k, value in pairs(arg2) do
            local var9, var10 = checkTypeRecursive(value)
            if not var9 then
                return false, string.format("error when checking key: %s - %s", k, var10)
            end
        end
        return true
    end

    return checkTypeRecursive(arg1)
end))
local var10 = t.intersection(
    t.strictInterface({
        uuid = t.string,
        timestamp = t.number,
        lang = t.string,
        langVersion = t.string,
        agent = t.string,
        agentVersion = t.string,
        threads = t.map(t.string, var2),
        mainThread = t.string,
        attributes = var8,
        annotations = var9,
        symbolication = t.optional(t.literal("minidump")),
        entryThread = t.optional(t.string),
        arch = t.optional(var3),
        fingerprint = t.optional(t.string),
        classifiers = t.optional(t.array(t.string)),
        sourceCode = t.optional(t.map(t.string, var4)),
        memory = t.optional(t.array(var6)),
        modules = t.optional(t.array(var7))
    }),
    function(arg1)
        local bool1 = false

        local threads = arg1.threads
        for _, thread in pairs(threads) do
            local stack = thread.stack
            if stack ~= nil then
                for _, value in ipairs(stack) do
                    if value.registers ~= nil then
                        bool1 = true
                        break
                    end
                end
            end

            if bool1 then
                break
            end
        end

        if bool1 and arg1.arch == nil then
            return false, "arch must exist if you want to have registers in the stack"
        end
        return true
    end
)

local module = { IAttributes = var8, IAnnotations = var9 }

module.__index = module

local function func1(sourceCode) -- Luacid: Inlined by compiler; 2 call sites recovered
    if sourceCode and type(sourceCode) == "table" then
        local var11 = Cryo.Dictionary.keys(sourceCode)
        if #var11 > 0 then
            local var12 = sourceCode[var11[1]]
            if var12 and var12.path ~= nil then
                return var12.path
            end
        end
    end
    return ""
end

function module.validate(arg1)
    return var10(arg1)
end

function module.new()
    local tbl1 = {
        uuid = HttpService:GenerateGUID(false):lower(),
        timestamp = os.time(),
        lang = "lua",
        langVersion = "Roblox",
        agent = "backtrace-Lua",
        agentVersion = "0.1.0",
        threads = {},
        mainThread = "default"
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module.addAttributes(arg1, arg2)
    if type(arg2) ~= "table" then
        warn("Cannot add attributes of type: ", type(arg2))
        return
    end

    local attributes = arg1.attributes or {}

    arg1.attributes = Cryo.Dictionary.join(attributes, arg2)
end

function module.addAnnotations(arg1, arg2)
    if type(arg2) ~= "table" then
        warn("Cannot add annotations of type: ", type(arg2))
        return
    end

    local var11 = arg1.annotations or {}

    arg1.annotations = Cryo.Dictionary.join(var11, arg2)
end

function module:addStackToThread(stack, name)
    local threads = self.threads

    self.threads = Cryo.Dictionary.join(threads, { [name] = { name = name, stack = stack } })
end

function module:addStackToMainThread(arg1)
    self:addStackToThread(arg1, self.mainThread)
end

function module.fromMessageAndStack(errorMessage, arg1)
    local module2 = module.new()

    module2:addAttributes({ ["error.message"] = errorMessage })

    local var11, sourceCode = ProcessErrorStack(arg1)
    module2:addStackToMainThread(var11)
    module2.sourceCode = sourceCode

    module2:addAttributes({ MainSourcePath = func1(module2.sourceCode) })

    return module2
end

function module.fromDetails(arg1)
    local module2 = module.new()

    module2:addAttributes({ ["error.message"] = arg1.message })

    module2.sourceCode = {}

    local num1 = 0
    for i, stack in ipairs(arg1.stacks) do
        local var11, var12
        var11, var12, num1 = ProcessErrorStack(stack, num1)
        if i == 1 then
            module2:addStackToMainThread(var11)
        else
            module2:addStackToThread(var11, "stack" .. i)
        end
        module2.sourceCode = Cryo.Dictionary.join(module2.sourceCode, var12)
    end

    module2:addAnnotations(arg1.annotations)

    module2:addAttributes({ MainSourcePath = func1(module2.sourceCode) })

    return module2
end

return module
