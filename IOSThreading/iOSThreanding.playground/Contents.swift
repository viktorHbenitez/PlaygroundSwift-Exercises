import UIKit

/*:
 ## Theard "Thread of execution"
 - - - - - - - - - -

 Problem: the process to execute de data taking to long time to a table view to load data
 optimized the process to be executed
 get data take a time (URL, Web, BD, etc)
 
 Something is executed in the process

 - **Dispatch**      : To send off to a destination.
 - **Queue**        : A list or sequence of things.
 - **DispatchQueue** : Manages the execution of work items.
 
 qos : Quality of service (priority)
  - user interactive (highest)
  - User initated (second highest)
  - ...
  - background (lowest)
 
**Async** (Asynchronous) - Your program does not wait for code to finish. it continues on.  
**Sync** (Synchronues) - Your program waits for code / task to finish before continuing to the next task
 
 
 ## Closures
 Concept : Closure are self-contained blocks of funcionality that can be passed around and used in your code
 @escaping = A closure is said to escape a function when the closure is passed as an argument to the function, BUT it is called after the function returns
 @escaping = will be return later
 
 basic sintax examples:
 ```Swift
 (parameter) -> (GoingToReturn)
 ((Bool) -> Void)?
 ((Bool) -> ())?
 typealias handler = ((Bool) -> ())?
```
 Find more information [Description link](https://www.google.com)
 
 Sintaxis
 
 ```Swift
    var strParameter : String?
 ```
 ![image description](image.png)
 */



// Model
struct Data{
 
    
    
    /*
     Closures function that pass to other functions
     Concept : Closure are self-contained blocks of funcionality that can be passed around and used in your code
     @escaping = A closure is said to escape a function when the closure is passed as an argument to the function, BUT it is called after the function returns
     @escaping = will be return later */
    
    typealias blkHandler = (_ strData : String) -> ()
    
    static func getDataSecondOption( handler : @escaping blkHandler){
        DispatchQueue.global(qos: .userInteractive).async {
            // this code is executed in other thread
            // get data from other place
            sleep(4)
            DispatchQueue.main.async {
                // this code is executed in main thread
                handler("return data in main thread" )
            }
        }
        
    }
    
    
    
    static func getData(handler: ((_ strParameter : String) -> ())? ){ // simulate data process
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            // this code is executed in other thread
            sleep(5)

            DispatchQueue.main.async {
                // this code is executed in main thread
                handler?("get data in other thread")
            }
        }
    }
}


// process
func getModel(){
    Data.getData { (strParameterFuntion) in
        print("strParameterFuntion", strParameterFuntion)
    }
}

// process
func getModelWithTypealias(){
    
    Data.getDataSecondOption{ (strParameterFuntion) in
        print("strParameterFuntion", strParameterFuntion)
    }
}


getModel()

getModelWithTypealias()





