/*_____________________________________________________________________________
 │                                                                            |
 │ COPYRIGHT (C) 2023 Mihai Baneu                                             |
 │                                                                            |
 | Permission is hereby  granted,  free of charge,  to any person obtaining a |
 | copy of this software and associated documentation files (the "Software"), |
 | to deal in the Software without restriction,  including without limitation |
 | the rights to  use, copy, modify, merge, publish, distribute,  sublicense, |
 | and/or sell copies  of  the Software, and to permit  persons to  whom  the |
 | Software is furnished to do so, subject to the following conditions:       |
 |                                                                            |
 | The above  copyright notice  and this permission notice  shall be included |
 | in all copies or substantial portions of the Software.                     |
 |                                                                            |
 | THE SOFTWARE IS PROVIDED  "AS IS",  WITHOUT WARRANTY OF ANY KIND,  EXPRESS |
 | OR   IMPLIED,   INCLUDING   BUT   NOT   LIMITED   TO   THE  WARRANTIES  OF |
 | MERCHANTABILITY,  FITNESS FOR  A  PARTICULAR  PURPOSE AND NONINFRINGEMENT. |
 | IN NO  EVENT SHALL  THE AUTHORS  OR  COPYRIGHT  HOLDERS  BE LIABLE FOR ANY |
 | CLAIM, DAMAGES OR OTHER LIABILITY,  WHETHER IN AN ACTION OF CONTRACT, TORT |
 | OR OTHERWISE, ARISING FROM,  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR  |
 | THE USE OR OTHER DEALINGS IN THE SOFTWARE.                                 |
 |____________________________________________________________________________|
 |                                                                            |
 |  Author: Mihai Baneu                           Last modified: 28.Dec.2023  |
 |                                                                            |
 |___________________________________________________________________________*/

import qbs.FileInfo

Product {
    name: 'cmsis'
    type: 'lib'

    Depends { name: 'stm32' }

    stm32.includePaths: [
        'core',
        'device/' + stm32.targetSeries
    ]

    Group {
        condition: stm32.targetSeries == 'STM32F1'
        files: [
            'core/core_cm3.h'
        ]
    }

    Group {
        condition: stm32.targetSeries == 'STM32F4'
        files: [
            'core/core_cm4.h'
        ]
    }

    Group {
        condition: stm32.targetSeries == 'STM32H7'
        files: [
            'core/core_cm7.h'
        ]
    }

     Group {
        condition: stm32.targetSeries == 'STM32G0'
        files: [
            'core/core_cm0plus.h'
        ]
    }

    files: [
        'core/cmsis*.h',
        'device/' + stm32.targetSeries + '/*.h',
        'device/' + stm32.targetSeries + '/*.c'
    ]

    Export {
        Depends { name: 'stm32' }
        
        stm32.includePaths: [
            FileInfo.joinPaths(exportingProduct.sourceDirectory, 'core'),
            FileInfo.joinPaths(exportingProduct.sourceDirectory, 'device', stm32.targetSeries)
        ]
        stm32.libraryPaths: [ exportingProduct.destinationDirectory ]
    }
}
