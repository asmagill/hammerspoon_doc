hs._asm.doc
===========
Create documentation objects for interactive help within Hammerspoon

The documentation object created is a table with tostring metamethods allowing access to a specific functions documentation by appending the path to the method or function to the object created.

From the Hammerspoon console:

      doc = require("hs._asm.doc").fromRegisteredFiles()
      doc.hs.application

Results in:

      Manipulate running applications

      [submodules]
      hs.application.watcher

      [subitems]
      hs.application:activate([allWindows]) -> bool
      hs.application:allWindows() -> window[]
          ...
      hs.application:visibleWindows() -> win[]

By default, the internal core documentation is already registered for inclusion within this documentation object, but you can register additional documentation from 3rd party modules with `hs._asm.registerJSONFile(...)` or limit the documentation to a single specific file with `hs._asm.fromJSONFile(...)`.

Currently, this module is specific to Hammerspoon.

### Local Install
~~~bash
$ git clone https://github.com/asmagill/hammerspoon_doc
$ cd hammerspoon_doc
$ [PREFIX=/usr/local/share/lua/5.2/] make install
$ [PREFIX=/usr/local/share/lua/5.2/] make install-docs
~~~

Note that if you do not provide `PREFIX`, then it defaults to ~/.hammerspoon.

### Example Usage

~~~lua
docMaker = require("hs._asm.doc")
docMaker.registerJSONFile(docMaker.locateJSONFile("hs._asm.doc"))
doc = docMaker.fromRegisteredFiles()
~~~

### Functions


~~~lua
docMaker.fromJSONFile(jsonfile) -> doc-array
~~~
Builds a doc array construct from the JSON file provided.

Parameters:
 * jsonfile - A string containing the location of a JSON file

Returns:
 * A table containing the documentation data loaded from the JSON file


~~~lua
docMaker.fromRegisteredFiles(jsonfile) -> doc-array
~~~
Builds a doc array construct from the registered JSON files.

Parameters:
 * None

Returns:
 * A table containing the documentation data loaded from the registered JSON files

Notes:
 * By default, the internal core documentation is already registered.  If you wish to remove it from the list of registered sources, issue the command `docMaker.unregisterJSONFile(hs.docstrings_json_file)`.
 * The documentation object is created from the sources that are registered at the time of its invocation. If you register additional files later, you will need to reissue this command to build the updated documentation object.


~~~lua
docMaker.locateJSONFile(module) -> path | false, message
~~~
Locates the JSON file corresponding to the specified module by searching package.path and package.cpath.

Parameters:
 * module - the name of the module to locate a JSON file for

Returns:
 * the path to the JSON file, or `false, error` if unable to locate a corresponding JSON file.

Notes:
 * The JSON should be named 'full.module.name.json' and located in the same directory as the `lua` or `so` file which is used when the module is loaded via `require`.


~~~lua
docMaker.registeredFiles() -> table
~~~
Returns the list of registered JSON files.

Parameters:
 * None

Returns:
  * a table containing the list of registered JSON files


~~~lua
docMaker.registerJSONFile(jsonfile) -> status[, message]
~~~
Register a JSON file for inclusion when Hammerspoon generates internal documentation.

Parameters:
 * jsonfile - A string containing the location of a JSON file

Returns:
 * status - Boolean flag indicating if the file was registered or not.  If the file was not registered, then a message indicating the error is also returned.


~~~lua
docMaker.unregisterJSONFile(jsonfile) -> status[, message]
~~~
Remove a JSON file from the list of registered files.

Parameters:
 * jsonfile - A string containing the location of a JSON file

Returns:
 * status - Boolean flag indicating if the file was unregistered or not.  If the file was not unregistered, then a message indicating the error is also returned.


~~~lua
docMaker.validateJSONFile(jsonfile) -> status, message|table
~~~
Validate a JSON file potential inclusion in the Hammerspoon internal documentation.

Parameters:
 * jsonfile - A string containing the location of a JSON file

Returns:
 * status - Boolean flag indicating if the file was registered or not.
 * message|table - If the file did not contain valid JSON data, then a message indicating the error is returned; otherwise the parsed JSON data is returned as a table.


### Documentation

For this module, and other modules which support this documentation model, you also need to issue the following when installing the module:

    make install-docs

This will install the JSON file in the location expected by `hs._asm.doc.locateJSONFile(...)`.

If you are still using the internal `hs.doc` module, this JSON file is in a format suitable for use with Hammerspoon's `hs.doc.fromJSONFile(file)` function.

I will be proposing this module as a replacement for the `hs.doc` module when it has been tested further and the process for generating 3rd party documentation files is formally documented.

### License

> Released under MIT license.
>
> Copyright (c) 2015 Aaron Magill
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
>
