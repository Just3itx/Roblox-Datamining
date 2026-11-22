-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)
local VideoPlaybackCoordinator = require(MomentsParent.VideoUtils).VideoPlaybackCoordinator

local observeGuiOnScreen = require(script.Parent.observeGuiOnScreen)

local function useAvatarMomentFramerateHold(tbl1)
    local var1 = React.useMemo(function()
        local videoPlaybackCoordinator = VideoPlaybackCoordinator.new()
        local bool1 = false
        local bool2 = false
        local var1 = nil

        local function refresh() -- Luacid: Inlined by compiler; 3 call sites recovered
            local current = bool1 and tbl1.current
            if current == bool2 then
                return
            end
            bool2 = current
            if current then
                videoPlaybackCoordinator:requestPlayback("AvatarMomentScene", false, 0)
                return
            end
            videoPlaybackCoordinator:cancelPlayback("AvatarMomentScene", "AvatarMomentSceneStopped")
        end

        local function setShown(bool3: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
            bool1 = bool3
            refresh()
        end

        local function untrackPage() -- Luacid: Inlined by compiler; 1 call site recovered
            if var1 == nil then
                return
            end
            var1()
            var1 = nil
            setShown(false)
        end

        return {
            setShown = setShown,
            trackPage = function(arg1)
                untrackPage()
                var1 = observeGuiOnScreen(arg1, setShown)
            end,
            untrackPage = untrackPage,
            refresh = refresh
        }
    end, { tbl1 })

    React.useEffect(function()
        return function()
            var1.untrackPage()
            var1.setShown(false)
        end
    end, { var1 })

    return var1
end

return useAvatarMomentFramerateHold
