-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent

local join = require(FoundationParent.Dash).join

local tbl1 = {}
local module = {}

function module.equals(tbl2, tbl3): boolean
    if rawequal(tbl2, tbl3) then
        return true
    end

    return tbl2.DataModel == tbl3.DataModel
        and tbl2.PluginType == tbl3.PluginType
        and tbl2.PluginId == tbl3.PluginId
        and tbl2.Category == tbl3.Category
        and tbl2.ItemId == tbl3.ItemId
end

module.RESTRICTED_Mt = table.freeze({
    __eq = function(tbl2, tbl3)
        return module.equals(tbl2, tbl3)
    end
})

function module.wrap(tbl2)
    if table.isfrozen(tbl2) and getmetatable(tbl2) == module.RESTRICTED_Mt then
        return tbl2
    end

    if table.isfrozen(tbl2) then
        tbl2 = table.clone(tbl2)
    end
    return table.freeze((setmetatable(tbl2, module.RESTRICTED_Mt)))
end

function module.join(tbl2, tbl3)
    return module.wrap(join(tbl2, tbl3))
end

function module.toString(tbl2): string
    local var1 = table.create(5)

    local tbl3 = tbl2 or tbl1

    if not tbl3 then
        return ""
    end

    if tbl3.DataModel then
        table.insert(var1, `DataModel:{tbl3.DataModel}`)
    end
    if tbl3.PluginType then
        table.insert(var1, `PluginType:{tbl3.PluginType}`)
    end
    if tbl3.PluginId then
        table.insert(var1, `PluginId:{tbl3.PluginId}`)
    end
    if tbl3.Category then
        table.insert(var1, `Category:{tbl3.Category}`)
    end
    if tbl3.ItemId then
        table.insert(var1, `ItemId:{tbl3.ItemId}`)
    end

    return table.concat(var1, ", ")
end

function module.child(tbl2, itemId: string)
    local join2 = module.join
    local tbl3 = { ItemId = 0 }
    if tbl2.ItemId then
        itemId = `{tbl2.ItemId}/{itemId}`
    end

    tbl3.ItemId = itemId
    return join2(tbl2, tbl3)
end

function module.isNull(tbl2): boolean
    return tbl2.DataModel == "Null"
end

function module.isValid(arg1): boolean
    return type(arg1) == "table"
end

function module.isStudioUri(arg1): boolean
    return type(arg1) == "table"
        and (arg1.DataModel ~= nil or arg1.PluginType ~= nil or arg1.PluginId ~= nil or arg1.Category ~= nil or arg1.ItemId ~= nil)
end

function module.fromAction(pluginId: string, itemId: string)
    return module.wrap({ DataModel = "Standalone", PluginId = pluginId, Category = "Actions", ItemId = itemId })
end

function module.fromSetting(pluginId: string, itemId: string)
    return module.wrap({ DataModel = "Standalone", PluginId = pluginId, Category = "Settings", ItemId = itemId })
end

function module.fromWidget(pluginId: string, itemId: string)
    return module.wrap({ DataModel = "Standalone", PluginId = pluginId, Category = "Widgets", ItemId = itemId })
end

function module.fromPanel(pluginId: string, itemId: string)
    return module.wrap({ DataModel = "Standalone", PluginId = pluginId, Category = "Panels", ItemId = itemId })
end

return module
