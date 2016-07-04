//
// flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package khambe;

import khambe.util.PackageLog;

/**
 * khambe's internal logger. Games should use their own by calling `System.createLogger()` or
 * extending `PackageLog`.
 */
class Log extends PackageLog {}
