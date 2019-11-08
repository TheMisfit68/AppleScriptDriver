import Foundation

@available(OSX 10.13, *)
public class AppleScriptDriver{
    
    var shell:Process! = nil
    let fileManager = FileManager.default
    let appleScriptsFolder:URL
    let fileExtensions:[String] = ["", ".scpt", ".applescript"]
    
    public  init(){
        let applicationSupportDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        appleScriptsFolder = applicationSupportDirectory.appendingPathComponent("AppleScripts", isDirectory: true)
        let folderPath = appleScriptsFolder.path
        if !fileManager.fileExists(atPath: folderPath){
            do {
                try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print ("🛑:\tCouldn't create 'AppleScripts'-directory")
            }
        }
    }
    
    public func runScript(_ scriptName:String, arguments:[String]? = nil){
        
        let allAppleScripts = try? fileManager.contentsOfDirectory(atPath: appleScriptsFolder.path)
        var appleScriptPath:String? = nil
        var fileExtensionCounter = 0
        while (allAppleScripts != nil) && (appleScriptPath == nil) && (fileExtensionCounter < fileExtensions.count) {
            let fileName = scriptName+fileExtensions[fileExtensionCounter]
            if allAppleScripts!.contains(fileName){
                appleScriptPath = appleScriptsFolder.appendingPathComponent(fileName).path
            }
            fileExtensionCounter += 1
        }
        if let finalPath = appleScriptPath, fileManager.fileExists(atPath: finalPath){
            
            shell = Process()
            shell.launchPath = "/usr/bin/osascript" // =AppleScript
            shell.arguments = [finalPath]
            
            if arguments != nil{
                shell.arguments? += arguments!
            }
            shell.launch()
        }
    }
    
    
    
}
