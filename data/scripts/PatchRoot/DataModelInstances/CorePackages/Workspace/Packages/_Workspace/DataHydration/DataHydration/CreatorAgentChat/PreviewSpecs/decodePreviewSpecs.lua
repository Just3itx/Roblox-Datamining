-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PreviewSpecsTypes = require(script.Parent.PreviewSpecsTypes)

local function optionalString(arg1): string? -- Luacid: Inlined by compiler; 6 call sites recovered
    return if typeof(arg1) == "string" then arg1 else nil
end

local function decodePinned(pinned) -- Luacid: Inlined by compiler; 1 call site recovered
    return if pinned == PreviewSpecsTypes.PreviewSpecPinned.Pr or pinned == PreviewSpecsTypes.PreviewSpecPinned.Hash then pinned else nil
end

local function decodeItem(arg1)
    if typeof(arg1) ~= "table" then
        return nil
    end
    local prNumber = arg1.pr_number
    local override = arg1.override

    if typeof(prNumber) ~= "number" or typeof(override) ~= "string" or override == "" then
        return nil
    end

    return {
        prNumber = prNumber,
        title = optionalString(arg1.title) or "",
        draft = arg1.draft == true,
        override = override,
        publishedAt = optionalString(arg1.published_at),
        status = optionalString(arg1.status) or PreviewSpecsTypes.PreviewSpecStatus.Unverified,
        pinned = decodePinned(arg1.pinned)
    }
end

local function decodePreviewSpecs(arg1)
    if typeof(arg1) ~= "table" then
        error("preview-specs: response is not an object")
    end
    if arg1.schema_version ~= 1 then
        local error = error
        local schemaVersion = arg1.schema_version
        error(`preview-specs: unsupported schema_version {tostring(schemaVersion)}`)
    end
    if typeof(arg1.items) ~= "table" then
        error("preview-specs: items is not an array")
    end

    local items = {}
    for _, item in ipairs(arg1.items) do
        local var1 = decodeItem(item)
        if var1 ~= nil then
            table.insert(items, var1)
        end
    end

    return {
        environment = optionalString(arg1.environment),
        agent = optionalString(arg1.agent),
        refreshedAt = optionalString(arg1.refreshed_at),
        items = items
    }
end

return decodePreviewSpecs
