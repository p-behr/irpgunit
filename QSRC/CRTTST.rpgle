      // ==========================================================================
      //  iRPGUnit - Implementation of RUCRTTST command.
      // ==========================================================================
      //  Copyright (c) 2013-2019 iRPGUnit Project Team
      //  All rights reserved. This program and the accompanying materials
      //  are made available under the terms of the Common Public License v1.0
      //  which accompanies this distribution, and is available at
      //  http://www.eclipse.org/legal/cpl-v10.html
      // ==========================================================================
      // >>PRE-COMPILER<<
      //   >>CRTCMD<<  CRTRPGMOD MODULE(&LI/&OB) SRCFILE(&SL/&SF) SRCMBR(&SM);
      //   >>IMPORTANT<<
      //     >>PARM<<  OPTION(*EVENTF);
      //     >>PARM<<  DBGVIEW(*LIST);
      //   >>END-IMPORTANT<<
      //   >>EXECUTE<<
      // >>END-PRE-COMPILER<<
      // ==========================================================================

      /include qinclude,H_SPEC
      /include qinclude,COPYRIGHT

      //----------------------------------------------------------------------
      //   IMPORTS
      //----------------------------------------------------------------------

      /include qinclude,STRING
      /include qinclude,PGMMSG
      /include qinclude,TEMPLATES
      /include qinclude,SYSTEMAPI
      /include qinclude,TESTUTILS
      /include qinclude,TAGTST
      /include qinclude,OBJECT

      //----------------------------------------------------------------------
      //   PUBLIC PROTOTYPES
      //----------------------------------------------------------------------

      /include qinclude,CRTTST

      //----------------------------------------------------------------------
      //   PRIVATE PROTOTYPES
      //----------------------------------------------------------------------

     D crtRpgMod       pr
     D  testPgm                            const likeds(Object_t)
     D  srcFile                            const likeds(Object_t)
     D  srcMbr                             const like(SrcMbr_t.mbr)
     D  srcStmf                     256a   const varying options(*varsize)
     D  cOption                            const likeds(Options_t)
     D  dbgView                            const like(DbgView_t)
     D  pOption                            const likeds(Options_t)
     D  compileopt                 5000a   const varying options(*varsize)

     D dltMod          pr
     D  testPgm                            const likeds(Object_t)

     D crtSrvPgm       pr                  likeds(Object_t)
     D  testPgm                            const likeds(Object_t)
     D  bndSrvPgm                          const likeds(ObjectArray_t)
     D  bndDir                             const likeds(ObjectArray_t)
     D  module                             const likeds(ObjectArray_t)
     D  bOption                            const likeds(Options_t)
     D  actGrp                             const like(ActivationGroup_t)
     D  text                               const like(Text_t    )


      //----------------------------------------------------------------------
      //   GLOBAL VARIABLES
      //----------------------------------------------------------------------

     D srvPgm          ds                  likeds(Object_t)


      //----------------------------------------------------------------------
      //   MAIN PROGRAM
      //----------------------------------------------------------------------

     D crtTst...
     D                 pr
     D  testPgm                            const likeds(Object_t)
     D  srcFile                            const likeds(Object_t)
     D  srcMbr                             const like(SrcMbr_t.mbr)
     D  srcStmf                     256a   const varying options(*varsize)
     D  text                               const like(Text_t)
     D  cOption                            const likeds(Options_t)
     D  dbgView                            const like(DbgView_t)
     D  bndSrvPgm                          const likeds(ObjectArray_t)
     D  bndDir                             const likeds(ObjectArray_t)
     D  bOption                            const likeds(Options_t)
     D  actGrp                             const like(ActivationGroup_t)
     D  module                             const likeds(ObjectArray_t)
     D  pOption                            const likeds(Options_t)
     D  compileopt                 5000a   const varying options(*varsize)

     D crtTst...
     D                 pi
     D  testPgm                            const likeds(Object_t)
     D  srcFile                            const likeds(Object_t)
     D  srcMbr                             const like(SrcMbr_t.mbr)
     D  srcStmf                     256a   const varying options(*varsize)
     D  text                               const like(Text_t)
     D  cOption                            const likeds(Options_t)
     D  dbgView                            const like(DbgView_t)
     D  bndSrvPgm                          const likeds(ObjectArray_t)
     D  bndDir                             const likeds(ObjectArray_t)
     D  bOption                            const likeds(Options_t)
     D  actGrp                             const like(ActivationGroup_t)
     D  module                             const likeds(ObjectArray_t)
     D  pOption                            const likeds(Options_t)
     D  compileopt                 5000a   const varying options(*varsize)

     D text2           s                   like(text) inz
     D srcMbr2         s                   like(srcMbr) inz
     D i               s             10i 0
     D mbrType         s             10a
     D tmpOpts         ds                  likeds(Options_t)
     D qSrcFile        ds                  likeds(Object_t)
     D libResolved     s             10a

       if srcStmf = *blanks;
           qSrcFile = srcFile;

           if (not Object_exists(qSrcFile: '*FILE'));
               sndEscapeMsgAboveCtlBdy(
            'Source file ' + %trim(qSrcFile.nm) + ' not found in library ' +
                                   %trim(qSrcFile.lib) + '.' );
           endif;

           if (%subst(qSrcFile.lib: 1: 1) = '*');
               libResolved = Object_resolveLibrary(qSrcFile: '*FILE');
           else;
               if (not Object_exists(qSrcFile: '*FILE'));
                   libResolved = '';
               else;
                   libResolved = qSrcFile.lib;
               endif;
           endif;

           if (libResolved = '');
               sndEscapeMsgAboveCtlBdy(
                 'Library ' + %trim(qSrcFile.lib) + ' not found.' );
           endif;

           qSrcFile.lib = libResolved;

           if (srcMbr = '*TSTPGM');
               srcMbr2 = testPgm.nm;
           else;
               srcMbr2 = srcMbr;
           endif;

           if (not Object_exists(qSrcFile: '*FILE': srcMbr2));
               sndEscapeMsgAboveCtlBdy(
                  'Member ' + %trim(srcMbr2) + ' not found in source file ' +
                        %trim(qSrcFile.lib) + '/' + %trim(qSrcFile.nm) + '.' );
           endif;

           if (srcMbr = '*TSTPGM');
               mbrType = getMemberType(qSrcFile.nm: qSrcFile.lib: testPgm);
               if (mbrType = MBR_RPGLE);
                   tmpOpts = cOption;
               else;
                   tmpOpts = pOption;
               endif;
               for i = 1 to tmpOpts.size;
                   if (tmpOpts.option(i) = '*EVENTF');
                       sndEscapeMsgAboveCtlBdy(
                          'Compile option *EVENTF is not +
                           allowed with source member *TSTPGM, +
                           because it does not work in RDi. Specify +
                           the name of the source member.' );
                   endif;
               endfor;
           endif;
       endif;

       monitor;

         if text <> '*BLANK' and not startsWith('RPGUnit' : text);
            text2 = 'RPGUnit - ' + text;
         else;
            text2 = text;
         endif;

         crtRpgMod( testPgm : qSrcFile : srcMbr2 : srcStmf :
                    cOption : dbgView : pOption : compileopt );
         srvPgm = crtSrvPgm(
                     testPgm : bndSrvPgm : bndDir : module : bOption :
                     actGrp : text2);

         tagTstSrvPgm(srvPgm : qSrcFile : srcMbr2);

         sndCompMsg( 'Test program ' + %trim(srvPgm.nm)
                   + ' created in library ' + %trim(srvPgm.lib) + '.' );

       on-error;
         sndEscapeMsgAboveCtlBdy( 'Unable to create test '
                                  + %trim(testPgm.nm) + '.' );
       endmon;

       monitor;
         dltMod( testPgm );
       on-error;
       endmon;

       *inlr = *on;

       dcl-proc validateSourceMember;
          dcl-pi *n  ind;
              srcFile  likeds(Object_t);
              srcMbr   like(SrcMbr_t.mbr);
          end-pi;

       end-proc;

     P crtRpgMod...
     P                 b
     D                 pi
     D  testPgm                            const likeds(Object_t)
     D  srcFile                            const likeds(Object_t)
     D  srcMbr                             const like(SrcMbr_t.mbr)
     D  srcStmf                     256a   const varying options(*varsize)
     D  cOption                            const likeds(Options_t)
     D  dbgView                            const like(DbgView_t)
     D  pOption                            const likeds(Options_t)
     D  compileopt                 5000a   const varying options(*varsize)

      // A command to be executed.
     D cmd             s                   like(Cmd_t)
      /free

         cmd = getCrtRpgModCmd( testPgm : srcFile : srcMbr : srcStmf :
                                cOption : dbgView: pOption : compileopt );
         sndInfoMsg( cmd );
         qcmdexc( cmd : %len(cmd) );

      /end-free
     P                 e


     P dltMod...
     P                 b
     D                 pi
     D  testPgm                            const likeds(Object_t)

      // A command to be executed.
     D cmd             s                   like(Cmd_t)
      /free

         cmd = getDltModCmd( testPgm );
         qcmdexc( cmd : %len(cmd) );

      /end-free
     P                 e


     P crtSrvPgm...
     P                 b
     D                 pi                  likeds(Object_t)
     D  testPgm                            const likeds(Object_t)
     D  bndSrvPgm                          const likeds(ObjectArray_t)
     D  bndDir                             const likeds(ObjectArray_t)
     D  module                             const likeds(ObjectArray_t)
     D  bOption                            const likeds(Options_t)
     D  actGrp                             const like(ActivationGroup_t)
     D  text                               const like(Text_t)

      // Export all procedures from the service program.
     D EXPORT_ALL      c                   const('*ALL')
      // A command to be executed.
     D cmd             s                   like(Cmd_t)
      // Bound Service Programs, with RPGUnit services included.
     D bndSrvPgmWithRU...
     D                 ds                  likeds(ObjectArray_t)
      // Completion message data.
     D compMsgData     s            256a
      // Target service program.
     D targetSrvPgm    ds                  likeds(Object_t)

      /free

         bndSrvPgmWithRU = bndSrvPgm;
         bndSrvPgmWithRU.size += 1;
         bndSrvPgmWithRU.object(bndSrvPgmWithRU.size).nm = 'RUTESTCASE';
         bndSrvPgmWithRU.object(bndSrvPgmWithRU.size).lib = '*LIBL';

         cmd = getCrtSrvPgmCmd( testPgm :
                                bndSrvPgmWithRU :
                                bndDir :
                                module :
                                bOption :
                                EXPORT_ALL :
                                actGrp :
                                text );
         sndInfoMsg( cmd );
         qcmdexc( cmd : %len(cmd) );

         compMsgData = rcvMsgData( '*COMP' );
         targetSrvPgm = %subst( compMsgData : 1 : 20 );

         return targetSrvPgm;

      /end-free
     P                 e


     P getCrtSrvPgmCmd...
     P                 b                   export
     D                 pi                        like(Cmd_t)
     D  testPgm                            const likeds(Object_t)
     D  bndSrvPgm                          const likeds(ObjectArray_t)
     D  bndDir                             const likeds(ObjectArray_t)
     D  modules                            const likeds(ObjectArray_t)
     D  options                            const likeds(Options_t)
     D  export                             const like(Export_t)
     D  actGrp                             const like(ActivationGroup_t)
     D  text                               const like(Text_t )

      // Command string accumulator.
     D module          ds                  likeds(modules)
      // Command string accumulator.
     D cmd             s                   like(Cmd_t)
      // Counter.
     D i               s             10i 0

      /free

        module = addTestCaseModule( modules : testPgm );

        cmd = 'CRTSRVPGM SRVPGM(' + serializeObjectName( testPgm ) + ') ';
        // cmd += 'MODULE(QTEMP/' + %trim(testPgm.nm) + ') ';
        // cmd += 'MODULE(' + serializeObjectName( testPgm ) + ') ';
        cmd += serializeObjectArray( 'MODULE'    : module    );
        cmd += serializeObjectArray( 'BNDSRVPGM' : bndSrvPgm );
        cmd += serializeObjectArray( 'BNDDIR'    : bndDir    );
        cmd += serializeOptions( 'OPTION' : options );
        cmd += serializeValue( 'ACTGRP' : actGrp );
        cmd += serializeString( 'TEXT' : text );
        cmd += serializeString( 'DETAIL' : '*BASIC' );

        if export <> *blank;
          cmd += 'EXPORT(' + %trim(export) + ') ';
        endif;

        return cmd;

      /end-free
     P                 e

     P addTestCaseModule...
     P                 b                   export
     D                 pi                        likeds(ObjectArray_t)
     D  modules                            const likeds(ObjectArray_t)
     D  testCase                           const likeds(Object_t)

     D rtnModules      ds                  likeDs(ObjectArray_t) inz
     D i               s             10i 0 inz
      /free

         rtnModules.size = 1;
         rtnModules.object(rtnModules.size) = testCase;

         for i = 1 to modules.size;
            rtnModules.size = rtnModules.size + 1;
            rtnModules.object(rtnModules.size) = modules.object(i);
         endfor;

         return rtnModules;

      /end-free
     P                 e


     P getCrtRpgModCmd...
     P                 b                   export
     D                 pi                        like(Cmd_t)
     D  testPgm                            const likeds(Object_t)
     D  srcFile                            const likeds(Object_t)
     D  srcMbr                             const like(SrcMbr_t.mbr)
     D  srcStmf                     256a   const varying options(*varsize)
     D  cOptions                           const likeds(Options_t)
     D  dbgView                            const like(DbgView_t)
     D  pOptions                           const likeds(Options_t)
     D  compileopt                 5000a   const varying options(*varsize)

      // Command string accumulator.
     D cmd             s                   like(Cmd_t)
     D dbgCompileOpt   s                   like(compileOpt)
      // Counter.
     D i               s             10i 0

      /free

        // cmd = 'CRTRPGMOD MODULE(QTEMP/' + %trim(testPgm.nm) + ') ';

        // source type determines the compile command
        select;
          // RPGLE
          when getMemberType(srcFile.nm: srcFile.lib: testPgm) = MBR_RPGLE;
            cmd = 'CRTRPGMOD MODULE(' + serializeObjectName( testPgm ) + ') ';

            if srcStmf = *blank;
              cmd += 'SRCFILE(' + serializeObjectName( srcFile ) + ') ';
              cmd += serializeValue( 'SRCMBR' : srcMbr );
            else;
              cmd += 'SRCSTMF(' + srcStmf + ') ';
            endif;

            cmd += serializeOptions( 'OPTION' : cOptions );
            cmd += serializeValue( 'DBGVIEW' : dbgView );

          // SQLRPGLE
          when getMemberType(srcFile.nm: srcFile.lib: testPgm) = MBR_SQLRPGLE;
            cmd = 'CRTSQLRPGI OBJ(' + serializeObjectName( testPgm ) + ') ';

            if srcStmf = *blank;
              cmd += 'SRCFILE(' + serializeObjectName( srcFile ) + ') ';
              cmd += serializeValue( 'SRCMBR' : srcMbr );
            else;
              cmd += 'SRCSTMF(' + srcStmf + ') ';
            endif;

            cmd += serializeOptions( 'OPTION' : pOptions );
            cmd += serializeValue('OBJTYPE': '*MODULE');
            cmd += serializeValue( 'DBGVIEW' : '*NONE');

            if compileopt <> *blank;
              dbgCompileOpt = removeQuotes(compileOpt);
              if (%scan( PARM_DBGVIEW + '(' : uCase( compileOpt )) = 0);
                dbgCompileOpt += ' ' + serializeValue( 'DBGVIEW' : dbgView );
              endif;
            else;
              dbgCompileOpt = serializeValue( 'DBGVIEW' : dbgView);
            endif;

            cmd += serializeString( 'COMPILEOPT' : dbgCompileOpt);

         // something we don't know about yet
         other;
            cmd = 'RUCRTTST: Unknown source member type';
         endsl;

        return cmd;

      /end-free
     P                 e


     P getDltModCmd...
     P                 b                   export
     D                 pi                        like(Cmd_t)
     D  testPgm                            const likeds(Object_t)

      // Command string accumulator.
     D cmd             s                   like(Cmd_t)

      /free

        cmd = 'DLTMOD MODULE(' + serializeObjectName( testPgm ) + ') ';

        return cmd;

      /end-free
     P                 e


     PserializeObjectArray...
     P                 b                   export
     D                 pi                        like(SerializedArray_t)
     D headToken                           const like(HeadToken_t)
     D array                               const likeds(ObjectArray_t)

      // Serialized Object Array.
     D serialized      s                   like(SerializedArray_t)
      // Counter.
     D i               s             10i 0

      /free

        if array.size = 0;
          return '';
        endif;

        serialized = %trim(headToken) + '(';

        for i = 1 to array.size;
          serialized += serializeObjectName( array.object(i) ) + ' ';
        endfor;

        serialized += ') ';

        return serialized;

      /end-free
     P                 e


     P serializeObjectName...
     P                 b                   export
     D                 pi                        like(SerializedObject_t)
     D  object                             const likeds(Object_t)

      // Serialized object name.
     D serialized      s                   like(SerializedObject_t) inz('')

      /free

        if object.lib <> *blank;
          serialized += %trim(object.lib) + '/';
        endif;

        serialized += %trim(object.nm);

        return serialized;

      /end-free
     P                 e


     PserializeOptions...
     P                 b                   export
     D                 pi                        like(SerializedOptions_t)
     D headToken                           const like(HeadToken_t)
     D options                             const likeds(Options_t)

      // Serialized Options.
     D serialized      s                   like(SerializedOptions_t)
      // Counter.
     D i               s             10i 0

      /free

        if options.size = 0;
          return '';
        endif;

        serialized = %trim(headToken) + '(';

        for i = 1 to options.size;
          serialized += %trim(options.option(i)) + ' ';
        endfor;

        if options.size > 0;
          serialized += ') ';
        endif;

        return serialized;

      /end-free
     P                 e

     PserializeString...
     P                 b                   export
     D                 pi                        like(SerializedString_t)
     D headToken                           const like(HeadToken_t)
     D text                        5000a   const varying options(*varsize)

      // Serialized Options.
     D serialized      s                   like(SerializedString_t)
      // Counter.
     D i               s             10i 0

      /free

        if %Len(%TrimR(text)) = 0;
          return '';
        endif;

        if startsWith(QUOTE: %trimL(text));
           serialized = %trim(headToken) + '(' + text + ')';
           return serialized;
        endif;

        serialized = %trim(headToken) + '(' + QUOTE;

        for i = 1 to %Len(%TrimR(text));
           serialized = serialized + %Subst(text: i: 1);
           if %Subst(text: i: 1) = QUOTE;
              serialized = serialized + QUOTE;
           endif;
        endfor;

        serialized = serialized + QUOTE + ') ';

        return serialized;

      /end-free
     P                 e

     PserializeValue...
     P                 b                   export
     D                 pi                        like(SerializedString_t)
     D headToken                     10a   const
     D value                               const like(String_t)

      // Serialized Options.
     D serialized      s                   like(SerializedString_t)

      /free

        if %Len(%trim(value)) = 0;
          return '';
        endif;

        serialized = %trim(headToken) + '(' + %Trim(value) + ') ';

        return serialized;

      /end-free
     P                 e
 