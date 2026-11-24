-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericChallengesParent = script:FindFirstAncestor("GenericChallenges").Parent

local CoreGui = game:GetService("CoreGui")

local _React = require(GenericChallengesParent.React)
local ReactRoblox = require(GenericChallengesParent.ReactRoblox)

local function defaultShutdownGame()
    game:Shutdown()
end

local function defaultMount(arg1, arg2)
    local root = ReactRoblox.createRoot(Instance.new("Folder"))
    root:render(ReactRoblox.createPortal(arg1, arg2))

    return function()
        root:unmount()
    end
end

local tbl1 = ({})

return function(tbl2)
    local challengeId = tbl2.challengeId
    if tbl1[challengeId] then
        return
    end
    tbl1[challengeId] = true

    local var1 = tbl2.shutdownGame or defaultShutdownGame
    local var2 = tbl2.container or CoreGui
    local var3 = tbl2.mount or function(arg1)
        return (defaultMount(arg1, var2))
    end

    local function func1() end
    local function teardown()
        tbl1[challengeId] = nil
        func1()
        if tbl2.shutdownOnTeardown then
            var1()
        end
    end

    local success, result = pcall(var3, tbl2.render(teardown))
    if not success then
        tbl1[challengeId] = nil
        error(result)
    end
    func1 = result
end
