-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local Motion = require(script.Motion)
local useMotion = require(script.Utility.useMotion)
local AnimatePresence = require(script.AnimatePresence.AnimatePresence)
local usePresence = require(script.AnimatePresence.usePresence)
local _Types = require(script.Types)

return {
    createState = Motion.createState,
    animate = Motion.animate,
    transition = Motion.transition,
    useMotion = useMotion,
    usePresence = usePresence,
    AnimatePresence = AnimatePresence,
    TransitionPreset = require(script.Enums.TransitionPreset)
}
