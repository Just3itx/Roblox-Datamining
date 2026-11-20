-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact084
local FFlagViewRecyclerReact08 = require(script:FindFirstAncestor("ViewRecyclerRoblox").Flags).FFlagViewRecyclerReact08
local ViewRecyclerRoblox = script:FindFirstAncestor("ViewRecyclerRoblox")
local ViewRecycler = require(ViewRecyclerRoblox.Parent.ViewRecycler)

local VacantHosts = require(ViewRecyclerRoblox.RobloxAdapter.VacantHosts)

return {
    create = function(tbl1) -- name: createRecyclingScope
        if FFlagViewRecyclerReact084 then
            assert(typeof(tbl1.vacantHostParent) == "Instance", "createRecyclingScope: vacantHostParent must be an Instance")
        end

        local itemViewAdapter = tbl1.itemViewAdapter
        local maxPoolSize = tbl1.maxPoolSize

        local function getInstance(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
            if tbl1.getInstance ~= nil then
                arg1 = tbl1.getInstance(arg1)
            end

            assert(typeof(arg1) == "Instance" and arg1:IsA("GuiObject"), "createRecyclingScope: ItemView host must be a GuiObject")

            return arg1
        end

        local batch = itemViewAdapter.batch or function(callback)
            callback()
        end

        local var2

        if FFlagViewRecyclerReact084 then
            var2 = {}
        else
            var2 = nil
            var2 = FFlagViewRecyclerReact08 and {} or var2
        end

        local recyclingScope = ViewRecycler.Adapter.createRecyclingScope({
            onPoolChanged = tbl1.diagnostics ~= nil and function(arg1)
                tbl1.diagnostics({
                    kind = ViewRecycler.Diagnostics.EventKind.PoolChanged,
                    action = arg1.action,
                    itemViewType = arg1.viewType,
                    occupiedDelta = arg1.occupiedDelta,
                    vacantDelta = arg1.vacantDelta,
                    totalDelta = arg1.totalDelta
                })
            end or nil,
            adapter = {
                create = function(arg1)
                    local var3 = itemViewAdapter.create(arg1)

                    if FFlagViewRecyclerReact084 then
                        var2[var3] = getInstance(var3).Destroying:Connect(function() end)
                        return var3
                    end
                    if FFlagViewRecyclerReact08 then
                        var2[var3] = getInstance(var3).Destroying:Connect(function() end)
                        return var3
                    end

                    local var4 = if tbl1.getInstance == nil then var3 else tbl1.getInstance(var3)
                    assert(typeof(var4) == "Instance" and var4:IsA("GuiObject"), "createRecyclingScope: ItemView host must be a GuiObject")

                    return var3
                end,
                destroy = function(arg1)
                    local var3 = if FFlagViewRecyclerReact084 then var2[arg1] else nil

                    if if FFlagViewRecyclerReact084 then var3 ~= nil else FFlagViewRecyclerReact08 then
                        if FFlagViewRecyclerReact084 then
                            var3:Disconnect()
                            var2[arg1] = nil
                        else
                            local var4 = var2[arg1]
                            if var4 ~= nil then
                                var4:Disconnect()
                                var2[arg1] = nil
                            end
                        end
                    end
                    if tbl1.destroyItemView ~= nil then
                        tbl1.destroyItemView(arg1)
                        return
                    end
                    getInstance(arg1):Destroy()
                end,
                onCreated = itemViewAdapter.onCreated,
                onEvicted = itemViewAdapter.onEvicted,
                batch = batch,
                isDestroyed = FFlagViewRecyclerReact084 and function(arg1): boolean
                    local var3 = var2[arg1]
                    return not (var3 == nil) and not var3.Connected
                end or FFlagViewRecyclerReact08 and function(arg1): boolean
                    local var3 = var2[arg1]
                    return not (var3 == nil) and not var3.Connected
                end or nil
            }
        })

        local vacantHosts = nil
        local tbl2

        if FFlagViewRecyclerReact084 then
            vacantHosts = VacantHosts.new()
            vacantHosts.setParent(tbl1.vacantHostParent)

            tbl2 = {
                bind = function(arg1)
                    local var3 = table.clone(arg1)
                    if var3.capacity == nil then
                        var3.capacity = maxPoolSize
                    end
                    return recyclingScope.bind(var3)
                end,
                dispose = function()
                    recyclingScope.dispose()
                    vacantHosts.destroy()
                end
            }
            VacantHosts.register(tbl2, vacantHosts)
        else
            tbl2 = nil
        end

        return not FFlagViewRecyclerReact084 and {
            bind = function(arg1)
                local var3 = table.clone(arg1)
                if var3.capacity == nil then
                    var3.capacity = maxPoolSize
                end
                return recyclingScope.bind(var3)
            end,
            dispose = recyclingScope.dispose
        } or tbl2
    end
}
