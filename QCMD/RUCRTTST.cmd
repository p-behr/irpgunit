     /* ===================================================================== */
     /*  iRPGUnit - Create Test Suite.                                        */
     /* ===================================================================== */
     /*  Copyright (c) 2013-2019 iRPGUnit Project Team                        */
     /*  All rights reserved. This program and the accompanying materials     */
     /*  are made available under the terms of the Common Public License v1.0 */
     /*  which accompanies this distribution, and is available at             */
     /*  http://www.eclipse.org/legal/cpl-v10.html                            */
     /* ===================================================================== */
     /*   >>PRE-COMPILER<<                                                    */
     /*     >>CRTCMD<<  CRTCMD        CMD(&LI/&OB) +                          */
     /*                               SRCFILE(&SL/&SF) SRCMBR(&SM);           */
     /*     >>IMPORTANT<<                                                     */
     /*       >>PARM<< PGM(&LI/RUCRTTST);                                     */
     /*       >>PARM<< HLPPNLGRP(&LI/RUCRTTST);                               */
     /*       >>PARM<< HLPID(RUCRTTST);                                       */
     /*     >>END-IMPORTANT<<                                                 */
     /*     >>EXECUTE<<                                                       */
     /*   >>END-PRE-COMPILER<<                                                */
     /* ===================================================================== */
             CMD        PROMPT('iRPGUnit - Create Test Suite')

             PARM       KWD(TSTPGM)                          +
                        TYPE(PGM)                            +
                        MIN(1)                               +
                        PROMPT('Test program')

             PARM       KWD(SRCFILE)                         +
                        TYPE(FILE)                           +
                        PROMPT('Source file')

             PARM       KWD(SRCMBR)                          +
                        TYPE(*NAME)                          +
                        LEN(10)                              +
                        DFT(*TSTPGM)                         +
                        SPCVAL(*TSTPGM)                      +
                        PROMPT('Source member')

             PARM       KWD(SRCSTMF) TYPE(*PNAME) LEN(256) +
                          PROMPT('Source stream file')

             PARM       KWD(TEXT)                            +
                        TYPE(*CHAR)                          +
                        LEN(50)                              +
                        VARY(*YES *INT2)                     +
                        DFT('RPGUnit - Test Case')           +
                        SPCVAL(*BLANK)                       +
                        PROMPT('Text ''description''')

             PARM       KWD(COPTION)                         +
                          TYPE(*CHAR)                        +
                          LEN(10)                            +
                          MAX(10)                            +
                          DFT(*SRCSTMT)                      +
                          RSTD(*YES)                         +
                          VALUES(*XREF                       +
                                 *NOXREF                     +
                                 *SECLVL                     +
                                 *NOSECLVL                   +
                                 *SHOWCPY                    +
                                 *NOSHOWCPY                  +
                                 *EXPDDS                     +
                                 *NOEXPDDS                   +
                                 *EXT                        +
                                 *NOEXT                      +
                                 *NOSHOWSKP                  +
                                 *SHOWSKP                    +
                                 *NOSRCSTMT                  +
                                 *SRCSTMT                    +
                                 *DEBUGIO                    +
                                 *NODEBUGIO                  +
                                 *UNREF                      +
                                 *NOUNREF                    +
                                 *NOEVENTF                   +
                                 *EVENTF   )                 +
                          PROMPT('Compile options')

             PARM       KWD(DBGVIEW)                         +
                          TYPE(*CHAR)                        +
                          LEN(10)                            +
                          DFT(*LIST)                         +
                          RSTD(*YES)                         +
                          VALUES(*STMT                       +
                                 *SOURCE                     +
                                 *LIST                       +
                                 *COPY                       +
                                 *ALL                        +
                                 *NONE)                      +
                          PROMPT('Debugging views')


             PARM       KWD(BNDSRVPGM)                       +
                          TYPE(BNDSRVPGM)                    +
                          MAX(50)                            +
                          PROMPT('Bind service program')

             PARM       KWD(BNDDIR)                          +
                          TYPE(BNDDIR)                       +
                          MAX(10)                            +
                          PROMPT('Binding directory')

             PARM       KWD(BOPTION)                         +
                          TYPE(*CHAR)                        +
                          LEN(10)                            +
                          MAX(2)                             +
                          RSTD(*YES)                         +
                          VALUES(*DUPPROC                    +
                                 *DUPVAR)                    +
                          PROMPT('Binding options')

         /* -------------------------------------- */
         /*   Additional parameters                */
         /* -------------------------------------- */

             PARM       KWD(ACTGRP)                          +
                          TYPE(*NAME)                        +
                          PMTCTL(*PMTRQS)                    +
                          SPCVAL(*CALLER)                    +
                          DFT(*CALLER)                       +
                          PROMPT('Activation group')

             PARM       KWD(MODULE)                          +
                          TYPE(MODULE)                       +
                          MAX(50)                            +
                          PMTCTL(*PMTRQS)                    +
                          PROMPT('Module')

             PARM       KWD(POPTION)                         +
                          TYPE(*CHAR)                        +
                          LEN(10)                            +
                          MAX(9)                             +
                          DFT(*SYSVAL)                       +
                          RSTD(*YES)                         +
                          VALUES(*XREF                       +
                                 *NOXREF                     +
                                 *COMMA                      +
                                 *PERIOD                     +
                                 *JOB                        +
                                 *SYSVAL                     +
                                 *SECLVL                     +
                                 *NOSECLVL                   +
                                 *SEQSRC                     +
                                 *NOSEQSRC                   +
                                 *CVTDAT                     +
                                 *NOCVTDAT                   +
                                 *SQL                        +
                                 *SYS                        +
                                 *OPTLOB                     +
                                 *NOOPTLOB                   +
                                 *NOEXTIND                   +
                                 *EXTIND                     +
                                 *EVENTF                     +
                                 *NOEVENTF )                 +
                          PMTCTL(*PMTRQS)                    +
                          PROMPT('Pre-compiler OPTIONS')

             PARM       KWD(COMPILEOPT)                      +
                          TYPE(*CHAR)                        +
                          LEN(5000)                          +
                          VARY(*YES *INT2)                   +
                          PMTCTL(*PMTRQS)                    +
                          PROMPT('Pre-Compiler COMPILEOPT')

 PGM:        QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) SPCVAL(*CURLIB)     +
                        PROMPT('Library')

 FILE:       QUAL       TYPE(*NAME) LEN(10) DFT(QRPGLESRC)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL(*LIBL *CURLIB) +
                        PROMPT('Library')

 BNDSRVPGM:  QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) SPCVAL(*NONE)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL(*LIBL)         +
                        PROMPT('Library')

 BNDDIR:     QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) SPCVAL(*NONE)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL(*LIBL *CURLIB *USRLIBL) +
                        PROMPT('Library')

 MODULE:     QUAL       TYPE(*NAME) LEN(10) DFT(*NONE) SPCVAL(*NONE)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL(*LIBL *CURLIB *USRLIBL) +
                        PROMPT('Library')

