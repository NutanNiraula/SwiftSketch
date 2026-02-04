
public enum Key: Int {
    case none           = 0
    // Alphanumeric keys
    case apostrophe     = 39
    case comma          = 44
    case minus          = 45
    case period         = 46
    case slash          = 47
    case number0        = 48
    case number1        = 49
    case number2        = 50
    case number3        = 51
    case number4        = 52
    case number5        = 53
    case number6        = 54
    case number7        = 55
    case number8        = 56
    case number9        = 57
    case semicolon      = 59
    case equal          = 61
    case letterA        = 65
    case letterB        = 66
    case letterC        = 67
    case letterD        = 68
    case letterE        = 69
    case letterF        = 70
    case letterG        = 71
    case letterH        = 72
    case letterI        = 73
    case letterJ        = 74
    case letterK        = 75
    case letterL        = 76
    case letterM        = 77
    case letterN        = 78
    case letterO        = 79
    case letterP        = 80
    case letterQ        = 81
    case letterR        = 82
    case letterS        = 83
    case letterT        = 84
    case letterU        = 85
    case letterV        = 86
    case letterW        = 87
    case letterX        = 88
    case letterY        = 89
    case letterZ        = 90
    
    // Function keys
    case space          = 32
    case escape         = 256
    case enter          = 257
    case tab            = 258
    case backspace      = 259
    case insert         = 260
    case delete         = 261
    case right          = 262
    case left           = 263
    case down           = 264
    case up             = 265
    case pageUp         = 266
    case pageDown       = 267
    case home           = 268
    case end            = 269
    case capsLock       = 280
    case scrollLock     = 281
    case numLock        = 282
    case printScreen    = 283
    case pause          = 284
    case function1      = 290
    case function2      = 291
    case function3      = 292
    case function4      = 293
    case function5      = 294
    case function6      = 295
    case function7      = 296
    case function8      = 297
    case function9      = 298
    case function10     = 299
    case function11     = 300
    case function12     = 301
    case leftShift      = 340
    case leftControl    = 341
    case leftAlt        = 342
    case leftSuper      = 343
    case rightShift     = 344
    case rightControl   = 345
    case rightAlt       = 346
    case rightSuper     = 347
    case kbMenu         = 348
    case leftBracket    = 91
    case backslash      = 92
    case rightBracket   = 93
    case grave          = 96
    
    // Keypad keys
    case keypad0        = 320
    case keypad1        = 321
    case keypad2        = 322
    case keypad3        = 323
    case keypad4        = 324
    case keypad5        = 325
    case keypad6        = 326
    case keypad7        = 327
    case keypad8        = 328
    case keypad9        = 329
    case keypadDecimal  = 330
    case keypadDivide   = 331
    case keypadMultiply = 332
    case keypadSubtract = 333
    case keypadAdd      = 334
    case keypadEnter    = 335
    case keypadEqual    = 336
    
    // Android key buttons
    var androidBack: RawValue {return 4}
    var androidMenu: RawValue {return 82}
    var androidVolumeUp: RawValue {return 24}
    var androidVolumeDown: RawValue {return 25}
    
    case unknown = -1
}
