# irpgunit

[Please see the project at sourceforge](https://irpgunit.sourceforge.io/ "iRPGUnit's Sourceforge page")

iRPGUnit is an open source plug-in for IBM Rational Developer for i. It enables you to develop and execute repeatable unit tests for RPG programs and service programs. The current version is 2.5.0.r.
The iRPGUnit plug-in uses a fork of the RPGUnit library, which was started by Lacton back in September 2006. The enhanced library adds an interface that enables RPGUnit to pass test results to the IBM Rational Developer for i. The development of the library as well as the plug-in was started by Mihael Schmidt at RPG Next Gen and is continued by the current developers.

iRPGUnit uses test suites to group test cases. A test case is a method that starts with 'test' and that is hosted and exported by a RPG module. A test suite is a service program that consists of one or more modules that exports test cases. Typically there is a one to one relation between the test suite service program and the module that contains the test cases.

iRPGUnit features are driven from our ideas and needs, but everybody is encouraged to contribute suggestions and manpower to improve the power of iRPGUnit.