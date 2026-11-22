-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function createImmersiveChromeMachine(tbl1, tbl2)
    local now = tbl2.now

    local isVisible = true
    local num1 = 0
    local var1 = nil
    local num2 = 0
    local bool2 = true

    local bool3 = false
    local bool4 = false
    local bool5 = false
    local var2 = now()
    local huge = -math.huge

    local function applyShow(str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
        if bool5 then
            return
        end

        num1 = 0
        var2 = now()
        if isVisible then
            return
        end
        isVisible = true
        tbl2.setChromeVisible(true, str1)
    end

    local function applyHide(str1: string?) -- Luacid: unused: defined but never referenced
        if not isVisible then
            return
        end
        isVisible = false
        huge = now()
        tbl2.setChromeVisible(false, str1 or "advance")
    end

    local function tryHide() -- Luacid: Inlined by compiler; 1 call site recovered
        if not bool4
            and isVisible
            and not (num1 < tbl1.hideAfterAdvances)
            and (not bool3 or bool2)
            and not (now() - var2 < tbl1.shownDwellMs)
            and isVisible
        then
            isVisible = false
            huge = now()
            tbl2.setChromeVisible(false, "advance")
        end
    end

    return {
        onActiveUpdate = function(num3: number, bool6: boolean, bool7: boolean)
            local var3 = var1
            if var3 == nil then
                var1 = num3
                bool2 = bool6
                bool3 = bool6
                return
            end

            local var4 = num3 - var3
            var1 = num3

            if var4 ~= 0 then
                if num2 > 0 and num2 <= num3 then
                    applyShow("endOfFeed")
                elseif var4 == 1 then
                    num1 += 1
                    tryHide()
                elseif var4 < 0 then
                    applyShow("reverse")
                else
                    num1 = 0
                end

                bool3 = false
                return
            end

            if bool7 then
                return
            end

            if bool6 then
                local bool8 = not bool2 and bool3
                bool2 = true
                bool3 = true
                if bool8 then
                    var2 = now()
                end
            elseif bool2 then
                bool2 = false
                if bool3 and not (bool4 or now() - huge < tbl1.hiddenCooldownMs) then
                    applyShow("pause")
                end
            end
        end,
        setForceShow = function(bool6: boolean)
            if bool6 == bool4 then
                return
            end
            bool4 = bool6
            if bool4 then
                applyShow("force")
            end
        end,
        setForceHide = function(bool6: boolean)
            if bool6 == bool5 then
                return
            end
            bool5 = bool6
            if not bool5 then
                applyShow("reveal")
                return
            end

            if not isVisible then
                return
            end
            isVisible = false
            huge = now()
            tbl2.setChromeVisible(false, "force")
        end,
        setCount = function(num3: number)
            num2 = num3
        end,
        reveal = function()
            applyShow("reveal")
        end,
        isVisible = function()
            return isVisible
        end
    }
end

return createImmersiveChromeMachine
