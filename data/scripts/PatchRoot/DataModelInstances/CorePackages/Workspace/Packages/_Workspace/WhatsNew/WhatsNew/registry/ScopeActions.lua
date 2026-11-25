-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T23:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local WhatsNew = script:FindFirstAncestor("WhatsNew")
local WhatsNewParent = WhatsNew.Parent

local Signals = require(WhatsNewParent.Signals)
local _Types = require(WhatsNew.Types)

local function assertValidKey(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
    assert(str1 ~= "", "scope action key must be a non-empty string")
end

return {
    createScopeActions = function(arg1)
        local tbl1 = {
            _actions = {},
            _openStateBindings = {},
            _openStateDisposers = {}
        }

        if arg1 ~= nil then
            for value, value2 in arg1 do
                assertValidKey(value)
                tbl1._actions[value] = value2
            end
        end

        local module = ({})

        function module.register(_, str1: string, arg2)
            assertValidKey(str1)
            assert(tbl1._actions[str1] == nil, `scope action already registered: {str1}`)
            tbl1._actions[str1] = arg2
        end

        function module.has(_, str1: string): boolean
            return tbl1._actions[str1] ~= nil
        end

        function module.invoke(_, str1: string)
            local _action = tbl1._actions[str1]
            assert(_action ~= nil, `unknown scope action key: {str1}`)
            _action()
        end

        function module.getRegisteredKeys(_)
            local registeredKeys = {}
            for k in tbl1._actions do
                table.insert(registeredKeys, k)
            end
            table.sort(registeredKeys)
            return registeredKeys
        end

        function module.toMap(_)
            return (table.clone(tbl1._actions))
        end

        function module.bindOpenState(_, arg2)
            assertValidKey(arg2.openActionKey)
            assertValidKey(arg2.closeActionKey)
            assert(arg2.getIsOpen ~= nil, "bindOpenState requires getIsOpen")
            assert(
                tbl1._actions[arg2.openActionKey] ~= nil,
                `bindOpenState openActionKey not registered: {arg2.openActionKey}`
            )
            assert(
                tbl1._actions[arg2.closeActionKey] ~= nil,
                `bindOpenState closeActionKey not registered: {arg2.closeActionKey}`
            )

            for _, _openStateBinding in tbl1._openStateBindings do
                assert(
                    _openStateBinding.openActionKey ~= arg2.openActionKey,
                    `open state already bound for openActionKey: {arg2.openActionKey}`
                )
                assert(
                    _openStateBinding.closeActionKey ~= arg2.closeActionKey,
                    `open state already bound for closeActionKey: {arg2.closeActionKey}`
                )
            end

            table.insert(tbl1._openStateBindings, arg2)
        end

        function module.stopOpenStateWiring(_)
            for _, _openStateDisposer in tbl1._openStateDisposers do
                _openStateDisposer()
            end
            table.clear(tbl1._openStateDisposers)
        end

        function module.startOpenStateWiring(_, arg2)
            module:stopOpenStateWiring()

            for _, _openStateBinding in tbl1._openStateBindings do
                local effect = Signals.createEffect(function(arg3)
                    local isOpen = _openStateBinding.getIsOpen(arg3)

                    arg2.getRuntimeStateSignal(arg3)
                    if isOpen then
                        arg2.notifyScopeOpened(_openStateBinding.openActionKey)
                        return
                    end
                    arg2.notifyScopeClosed(_openStateBinding.closeActionKey)
                end)

                table.insert(tbl1._openStateDisposers, effect)
            end
        end

        return module
    end,
    collectRegistryActionKeys = function(arg1)
        local tbl1 = ({})
        local result = {}

        local function addKey(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
            if str1 == nil or str1 == "" or tbl1[str1] then
                return
            end
            tbl1[str1] = true
            table.insert(result, str1)
        end

        for _, scopeTour in arg1.scopeTours do
            addKey(scopeTour.openActionKey)
            addKey(scopeTour.closeActionKey)
        end

        table.sort(result)
        return result
    end
}
