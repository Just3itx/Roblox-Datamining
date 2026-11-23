-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)
local ReactRoblox = require(AccountUpgradeParent.ReactRoblox)

local tbl1 = {
    [require(AccountUpgrade.AccountUpgradeFlow).Pioneer] = {
        canDismiss = true,
        getView = function()
            return (require(script.Parent.AccountUpgradePromptApp))
        end
    }
}

local var1 = nil
local var2 = nil

local module = {}

local function isCurrentHost(tbl2, arg1): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return var2 == tbl2 and var1 == arg1
end

local function cleanupHost(tbl2, arg1)
    if not isCurrentHost(tbl2, arg1) then
        return
    end

    var2 = nil
    var1 = nil
    if tbl2 then
        pcall(function()
            tbl2:unmount()
        end)
    end
    if arg1 then
        arg1:Destroy()
    end
end

function module.unmount()
    cleanupHost(var2, var1)
end

local function completeAfterCurrentEvent(root, screenGui: ScreenGui, callback: ((...any) -> (...any))?, tbl2) -- Luacid: Inlined by compiler; 3 call sites recovered
    task.defer(function()
        if not isCurrentHost(root, screenGui) then
            return
        end

        cleanupHost(root, screenGui)
        if callback then
            callback(tbl2)
        end
    end)
end

local function isMounted(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return not (var2 == nil or var1 == nil) and var1.Parent == CoreGui
end

local function unmountStaleHost() -- Luacid: Inlined by compiler; 1 call site recovered
    if var2 ~= nil and not isMounted() then
        module.unmount()
    end
end

function module.mount(tbl2): string
    unmountStaleHost()

    if isMounted() then
        return "already_mounted"
    end

    local var3 = tbl1[tbl2.flow]
    if var3 == nil then
        return "unsupported_flow"
    end

    local screenGui = Instance.new("ScreenGui")
    var1 = screenGui
    local var4 = nil

    local success, result = pcall(function()
        screenGui.Name = "InExperienceAccountUpgradePrompt"
        screenGui.AutoLocalize = false
        screenGui.DisplayOrder = 6
        screenGui.IgnoreGuiInset = true
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        screenGui.Parent = CoreGui

        local root = ReactRoblox.createRoot(screenGui)
        var4 = root
        var2 = root
        local bool1 = false
        local function func1(tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool1 then
                return
            end
            bool1 = true
            completeAfterCurrentEvent(root, screenGui, tbl2.onComplete, tbl3)
        end
        local function onComplete(arg1)
            func1({ reason = "success", result = arg1 })
        end

        local element

        if var3.canDismiss then
            local view = var3.getView()
            element = React.createElement(view, {
                flow = tbl2.flow,
                onDismiss = function()
                    func1({ reason = "user_closed" })
                end,
                onComplete = onComplete
            })
        else
            local view = var3.getView()
            element = React.createElement(view, { flow = tbl2.flow, onComplete = onComplete })
        end

        root:render(element)
    end)

    if not success then
        cleanupHost(var4, screenGui)
        error(result, 0)
    end

    return "mounted"
end

return module
