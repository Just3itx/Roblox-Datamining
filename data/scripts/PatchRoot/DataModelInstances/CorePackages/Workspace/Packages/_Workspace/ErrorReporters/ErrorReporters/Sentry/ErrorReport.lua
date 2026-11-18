-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:31:26Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local ErrorReportersParent = script:FindFirstAncestor("ErrorReporters").Parent
local Cryo = require(ErrorReportersParent.Cryo)
local t = require(ErrorReportersParent.t)
local _SentrySdk = require(ErrorReportersParent.SentrySdk)
local ProcessErrorStack = require(script.Parent.Parent.ProcessErrorStack)
local Constants = require(script.Parent.Constants)

local var1 = t.optional(t.map(t.string, t.some(t.string, t.number, t.boolean)))

local var2 = t.optional(t.map(t.string, function(arg1)
    local function checkTypeRecursive(arg2)
        if type(arg2) ~= "table" then
            return t.some(t.string, t.number, t.boolean)(arg2), nil
        end

        for k, value in pairs(arg2) do
            local var2, var3 = checkTypeRecursive(value)
            if not var2 then
                return false, string.format("error when checking key: %s - %s", k, var3 or "unknown error")
            end
        end
        return true, nil
    end

    local var2, var3 = checkTypeRecursive(arg1)
    return var2, var3
end))
local var3 = t.map(t.string, t.some(t.string, t.number, t.boolean))
local var4 = t.optional(t.map(t.string, var3))

local var5 = t.interface({
    type = t.optional(t.string),
    category = t.optional(t.string),
    message = t.optional(t.string),
    data = t.optional(t.table),
    level = t.optional(t.string),
    timestamp = t.optional(t.number),
    origin = t.optional(t.string)
})
local var6 = t.optional(t.array(var5))

local var7 = t.strictInterface({
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

local var8 = t.strictInterface({ name = t.optional(t.string), fault = t.optional(t.boolean), stack = t.optional(t.array(var7)) })

local var9 = t.intersection(
    t.strictInterface({
        threads = t.map(t.string, var8),
        message = t.optional(t.string),
        level = t.optional(t.string),
        attributes = var1,
        annotations = var2,
        tags = t.optional(t.map(t.string, t.string)),
        customMetadata = var4,
        breadcrumbs = var6,
        timestamp = t.optional(t.number)
    })
)

local module = {
    IAttributes = var1,
    IAnnotations = var2,
    ICustomMetadata = var4,
    IBreadcrumbs = var6
}
module.__index = module

function module.validate(arg1)
    return var9(arg1)
end

function module.new()
    local tbl1 = {
        threads = {},
        attributes = {},
        annotations = {},
        customMetadata = {},
        breadcrumbs = {}
    }

    setmetatable(tbl1, module)

    return tbl1
end

function module:addAttributes(tbl1)
    if type(tbl1) ~= "table" then
        warn("Cannot add attributes of type: ", type(tbl1))
        return
    end

    local attributes = self.attributes

    self.attributes = Cryo.Dictionary.join(attributes, tbl1)
end

function module:addAnnotations(tbl1)
    if type(tbl1) ~= "table" then
        warn("Cannot add annotations of type: ", type(tbl1))
        return
    end

    local annotations = self.annotations

    self.annotations = Cryo.Dictionary.join(annotations, tbl1)
end

local function sanitizeCustomMetadataGroup(arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local tbl1 = ({})

    for k, value in pairs(arg1) do
        local str1 = type(value)
        if str1 == "string" or str1 == "number" or str1 == "boolean" then
            tbl1[k] = value
        end
    end

    return if next(tbl1) == nil then nil else tbl1
end

function module:addCustomMetadata(tbl1)
    if type(tbl1) ~= "table" then
        warn("Cannot add custom metadata of type: ", type(tbl1))
        return
    end

    local customMetadata = self.customMetadata

    for k, value in pairs(tbl1) do
        local var10 = sanitizeCustomMetadataGroup(value)
        if var10 == nil then
            continue
        end

        local var11 = customMetadata[k]
        if var11 ~= nil then
            customMetadata[k] = Cryo.Dictionary.join(var11, var10)
        else
            customMetadata[k] = var10
        end
    end

    self.customMetadata = customMetadata
end

function module:addBreadcrumb(arg1)
    if type(arg1) ~= "table" then
        warn("Cannot add breadcrumb of type: ", type(arg1))
        return
    end

    local tbl1 = {
        type = arg1.type or "default",
        category = arg1.category,
        message = arg1.message,
        data = arg1.data,
        level = arg1.level or "info",
        origin = arg1.origin,
        timestamp = arg1.timestamp or os.time()
    }

    table.insert(self.breadcrumbs, tbl1)
end

function module.addBreadcrumbs(tbl1, tbl2)
    if type(tbl2) ~= "table" then
        warn("Cannot add breadcrumbs of type: ", type(tbl2))
        return
    end

    for _, value in ipairs(tbl2) do
        tbl1:addBreadcrumb(value)
    end
end

function module.fromMessageAndStack(message: string, str1: string, level)
    local module2 = module.new()

    module2.message = message
    module2.level = level or Constants.DEFAULT_ERROR_LEVEL

    local stack, var11 = ProcessErrorStack(str1)

    for _, value in stack do
        if value.sourceCode and var11[value.sourceCode] then
            value.sourceCode = var11[value.sourceCode].path
        end
    end

    module2.threads = {
        main = { name = "main", stack = stack }
    }

    return module2
end

function module:fromDetails()
    local var10

    if self.stack then
        var10 = module.fromMessageAndStack(self.message, self.stack, self.level)
    else
        var10 = module.new()
        var10.message = self.message
        var10.level = self.level or Constants.DEFAULT_ERROR_LEVEL
    end

    if self.annotations then
        var10:addAnnotations(self.annotations)
    end

    return var10
end

return module
