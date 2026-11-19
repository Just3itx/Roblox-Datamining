-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:30:42Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    fromError = require(script.fromError).fromError,
    toPromise = require(script.toPromise).toPromise,
    fromPromise = require(script.fromPromise).fromPromise,
    throwServerError = require(script.throwServerError).throwServerError,
    validateOperation = require(script.validateOperation).validateOperation,
    createOperation = require(script.createOperation).createOperation,
    transformOperation = require(script.transformOperation).transformOperation
}
