��    g      T              �  �  �  �   r  3  3	  S  g
  �  �  �  k  q  :  �   �  �   h  F   "  h   i  I   �  �     	   �  A   �  '   "  	   J     T  G   ]  �   �  �   R  Y   �  �   3  d     �   x  G     �  P  �  �     e  5   |  8   �    �  Q  �      ?"  )   M"  A   w"  8   �"  <   �"  <   /#  W  l#  [  �%  �   )    �*  �  �+  �  �-  �  Z0  �  Y2  L   �4  �   J5  k  6  �   {7    J8  �   L9  w   �9    m:  �   z;  �   <  �   �<  �   �=  i   w>     �>  �  ?  �  �B     wE     �E  `  �E  �  H  �  �I  �   �K  e  ZL  �   �M  �   }N  }  tO  R   �P    EQ    MR  �  gS    =U  <   VV  �  �V  j   c  7  �c  �   �d  �   Ie  �   �e  �   �f  1  �g  5   �i  �  �i  *   �k  �  �k     =m  �   Om  W  5n    �o  ;  �p  |  �q  �  Tu  �    w  R   �w  2   �w  X   #x  �  |x  ~  z  M  �}  �  �~  0  �  �  �  G  ��  �  B�  �   =�  *  *�  o   U�  �   ŏ  w   k�    �     ��  �   �  Q   ��     �      �  �   �  �  �  �  ��    '�  X  >�  �   ��  �  x�  �   %�  �  Ɲ  �  J�  ?   %�  r   e�  Q   ا  �  *�  ,  �  0   0�  E   a�  �   ��  ~   9�  t   ��  t   -�  E  ��  �  �  �  ��  �  *�    $�  .  @�  �  o�  �  �  �   ��  p  8�  �  ��  j  K�    ��  w  ��  �   7�  �  ��  ,  ��  �   ��  �  ��  �  l�  �   ��  M   ��  �  �  ;  ��  5   ��  ]   �  #  a�  *  ��  �  ��    6�  �  F�  �  ��  �  �  �  � �   P �  � �  r �  n	   D <   ] �  � j   O 7  � �   � �   | �    �   � �  � 5   �" �  �" 3   $ �  �$    �' �   �' W  x(   �) ;  �* |  , �  �/ �   C1 R   �1 2   32 �   f2  **LINE 3: WHY "LOCAL".** This line declares all the variables that will be used in the function. Actually it's not necessary to declare all variables at the start, and in a long function it would be better to declare variables just before using them. In fact it's not even necessary to declare variables at all, but an undeclared variable is "global". That's not desirable for any of the variables that are declared in line 1, because all of them are for use only within the function. **LINE 5: START THE MAIN LOOP.** Everything inside this "``for``" loop will be repeated as long as there is another index key. A tuple is fetched and can be referenced with variable :code:`t`. **LINE 5: WHY "PAIRS()".** Our job is to go through all the rows and there are two ways to do it: with :ref:`box.space.space_object:pairs() <box_space-pairs>` or with ``variable = select(...)`` followed by :samp:`for i, {n}, 1 do {some-function}(variable[i]) end`. We preferred ``pairs()`` for this example. **LINE 6: MEANING.** The function is :ref:`json.decode <json-decode>` which means decode a JSON string, and the parameter is t[2] which is a reference to a JSON string. There's a bit of hard coding here, we're assuming that the second field in the tuple is where the JSON string was inserted. For example, we're assuming a tuple looks like **LINE 6: WHY "PCALL".** If we simply said ``lua_table = json.decode(t[2]))``, then the function would abort with an error if it encountered something wrong with the JSON string - a missing colon, for example. By putting the function inside "``pcall``" (`protected call`_), we're saying: we want to intercept that sort of error, so if there's a problem just set ``is_valid_json = false`` and we will know what to do about it later. **LINE 8.** At last we are ready to get the JSON field value from the Lua table that came from the JSON string. The value in field_name, which is the parameter for the whole function, must be a name of a JSON field. For example, inside the JSON string ``'{"Hello": "world", "Quantity": 15}'``, there are two JSON fields: "Hello" and "Quantity". If the whole function is invoked with ``sum_json_field("Quantity")``, then ``field_value = lua_table[field_name]`` is effectively the same as ``field_value = lua_table["Quantity"]`` or even ``field_value = lua_table.Quantity``. Those are just three different ways of saying: for the Quantity field in the Lua table, get the value and put it in variable :code:`field_value`. **LINE 9: WHY "IF".** Suppose that the JSON string is well formed but the JSON field is not a number, or is missing. In that case, the function would be aborted when there was an attempt to add it to the sum. By first checking ``type(field_value) == "number"``, we avoid that abortion. Anyone who knows that the database is in perfect shape can skip this kind of thing. -- if tester is left over from some previous test, destroy it
box.space.tester:drop()
box.schema.space.create('tester')
box.space.tester:create_index('primary', {parts = {1, 'unsigned'}}) ... Well, actually it won't always look like this because ``math.random()`` produces random numbers. But for the illustration purposes it won't matter what the random string values are. :ref:`Indexed pattern search <c_lua_tutorial-indexed_pattern_search>`. :ref:`Insert one million tuples with a Lua stored procedure <c_lua_tutorial-insert_one_million_tuples>`, :ref:`Sum a JSON field for all tuples <c_lua_tutorial-sum_a_json_field>`, And the function is complete. Time to test it. Starting with an empty database, defined the same way as the sandbox database in our :ref:`"Getting started" exercises <getting_started>`, Configure Create a function that calls another function and sets a variable Create a function that returns a string Delimiter EXAMPLE: For more about Lua loops see Lua manual `chapter 4.3.4 "Numeric for"`_. For more about Lua math-library functions see Lua users "`Math Library Tutorial`_". For more about Lua string-library functions see Lua users "`String Library Tutorial`_" . For more about Lua strings see Lua manual `chapter 2.4 "Strings"`_ . For more about functions see Lua manual `chapter 5 "Functions"`_. For more about Lua variables see Lua manual `chapter 4.2 "Local Variables and Blocks"`_ . For more about Tarantool insert and replace calls, see Tarantool manual section :ref:`Submodule box.space <box_space>`, :ref:`space_object:insert() <box_space-insert>`, and :ref:`space_object:replace() <box_space-replace>`. For more about Tarantool tuples see Tarantool manual section :ref:`Submodule box.tuple <box_tuple>`. For more on Lua ``os.clock()`` see Lua manual `chapter 22.1 "Date and Time"`_. For more on Lua print() see Lua manual `chapter 5 "Functions"`_. Here are three tutorials on using Lua stored procedures with Tarantool: Here is a generic function which takes a field identifier and a search pattern, and returns all tuples that match. |br| * The field must be the first field of a TREE index. |br| * The function will use `Lua pattern matching <http://www.lua.org/manual/5.2/manual.html#6.4.1>`_, which allows "magic characters" in regular expressions. |br| * The initial characters in the pattern, as far as the first magic character, will be used as an index search key. For each tuple that is found via the index, there will be a match of the whole pattern. |br| * To be :ref:`cooperative <atomic-cooperative_multitasking>`, the function should yield after every 10 tuples, unless there is a reason to delay yielding. |br| With this function, we can take advantage of Tarantool's indexes for speed, and take advantage of Lua's pattern matching for flexibility. It does everything that an SQL "LIKE" search can do, and far more. In earlier versions of Tarantool, multi-line functions had to be enclosed within "delimiters". They are no longer necessary, and so they will not be used in this tutorial. However, they are still supported. Users who wish to use delimiters, or users of older versions of Tarantool, should check the syntax description for :ref:`declaring a delimiter <console-delimiter>` before proceeding. Indexed pattern search Insert one million tuples with a Lua stored procedure Invoke the function with ``sum_json_field("Quantity")``. It is not necessary to destroy the old ``string_function()`` contents, they're simply overwritten. The first assignment invokes a random-number function in Lua's math library; the parameters mean “the number must be an integer between 65 and 90.” The second assignment invokes an integer-to-character function in Lua's string library; the parameter is the code point of the character. Luckily the ASCII value of 'A' is 65 and the ASCII value of 'Z' is 90 so the result will always be a letter between A and Z. It works. We'll just leave, as exercises for future improvement, the possibility that the "hard coding" assumptions could be removed, that there might have to be an overflow check if some field values are huge, and that the function should contain a :ref:`yield <atomic-threads_fibers_yields>` instruction if the count of tuples is huge. Lua tutorials Make a tuple out of a number and a string Modify main_function to insert a million tuples into the database Modify main_function to insert a tuple into the database Modify the function so it returns a one-letter random string Modify the function so it returns a ten-letter random string NOTE #1 "FIND AN APPROPRIATE INDEX" |br| The caller has passed space_name (a string) and field_no (a number). The requirements are: |br| (a) index type must be "TREE" because for other index types (HASH, BITSET, RTREE) a search with :ref:`iterator=GE <box_index-iterator-types>` will not return strings in order by string value; |br| (b) field_no must be the first index part; |br| (c) the field must contain strings, because for other data types (such as "unsigned") pattern searches are not possible; |br| If these requirements are not met by any index, then print an error message and return nil. NOTE #2 "DERIVE INDEX SEARCH KEY FROM PATTERN" |br| The caller has passed pattern (a string). The index search key will be the characters in the pattern as far as the first magic character. Lua's magic characters are % ^ $ ( ) . [ ] * + - ?. For example, if the pattern is "ABC.E", the period is a magic character and therefore the index search key will be "ABC". But there is a complication ... If we see "%" followed by a punctuation character, that punctuation character is "escaped" so remove the "%" when making the index search key. For example, if the pattern is "AB%$E", the dollar sign is escaped and therefore the index search key will be "AB$E". Finally there is a check that the index search key length must be at least three -- this is an arbitrary number, and in fact zero would be okay, but short index search keys will cause long search times. NOTE #3 -- "OUTER LOOP: INITIATE" |br| The function's job is to return a result set, just as `box.space...select <box_space-select>` would. We will fill it within an outer loop that contains an inner loop. The outer loop's job is to execute the inner loop, and possibly :ref:`yield <atomic-threads_fibers_yields>`, until the search ends. The inner loop's job is to find tuples via the index, and put them in the result set if they match the pattern. NOTE #4 "INNER LOOP: ITERATOR" |br| The for loop here is using pairs(), see the :ref:`explanation of what index iterators are <box_index-index_pairs>`. Within the inner loop, there will be a local variable named "tuple" which contains the latest tuple found via the index search key. NOTE #5 "INNER LOOP: BREAK IF INDEX KEY IS TOO GREAT" |br| The iterator is GE (Greater or Equal), and we must be more specific: if the search index key has N characters, then the leftmost N characters of the result's index field must not be greater than the search index key. For example, if the search index key is 'ABC', then 'ABCDE' is a potential match, but 'ABD' is a signal that no more matches are possible. NOTE #6 "INNER LOOP: BREAK AFTER EVERY 10 TUPLES -- MAYBE" |br| This chunk of code is for cooperative multitasking. The number 10 is arbitrary, and usually a larger number would be okay. The simple rule would be "after checking 10 tuples, yield, and then resume the search (that is, do the inner loop again) starting after the last value that was found". However, if the index is non-unique or if there is more than one field in the index, then we might have duplicates -- for example {"ABC",1}, {"ABC", 2}, {"ABC", 3}" -- and it would be difficult to decide which "ABC" tuple to resume with. Therefore, if the result's index field is the same as the previous result's index field, there is no break. NOTE #7 "INNER LOOP: ADD TO RESULT SET IF PATTERN MATCHES" |br| Compare the result's index field to the entire pattern. For example, suppose that the caller passed pattern "ABC.E" and there is an indexed field containing "ABCDE". Therefore the initial index search key is "ABC". Therefore a tuple containing an indexed field with "ABCDE" will be found by the iterator, because "ABCDE" > "ABC". In that case string.match will return a value which is not nil. Therefore this tuple can be added to the result set. NOTE #8 "OUTER LOOP: BREAK, OR YIELD AND CONTINUE" |br| There are three conditions which will cause a break from the inner loop: (1) the for loop ends naturally because there are no more index keys which are greater than or equal to the index search key, (2) the index key is too great as described in NOTE #5, (3) it is time for a yield as described in NOTE #6. If condition (1) or condition (2) is true, then there is nothing more to do, the outer loop ends too. If and only if condition (3) is true, the outer loop must yield and then continue. If it does continue, then the inner loop -- the iterator search -- will happen again with a new value for the index search key. Now that ``string_function`` exists, we can invoke it from another function. Now that it's a bit clearer how to make a variable, we can change ``string_function()`` so that, instead of returning a fixed literal "Hello world", it returns a random letter between 'A' and 'Z'. Now that it's clear how to insert one tuple into the database, it's no big deal to figure out how to scale up: instead of inserting with a literal value = 1 for the primary key, insert with a variable value = between 1 and 1 million, in a loop. Since we already saw how to loop, that's a simple thing. The only extra wrinkle that we add here is a timing function. Now that it's clear how to make a 10-letter random string, it's possible to make a tuple that contains a number and a 10-letter random string, by invoking a function in Tarantool's library of Lua functions. Now that it's clear how to make a tuple that contains a number and a 10-letter random string, the only trick remaining is putting that tuple into tester. Remember that tester is the first space that was defined in the sandbox, so it's like a database table. Now that it's clear how to produce one-letter random strings, we can reach our goal of producing a ten-letter string by concatenating ten one-letter strings, in a loop. Once again the ``string_function()`` can be invoked from main_function() which can be invoked with ``main_function()``. Once this is done, t will be the value of a new tuple which has two fields. The first field is numeric: 1. The second field is a random string. Once again the ``string_function()`` can be invoked from ``main_function()`` which can be invoked with  ``main_function()``. Read the following Lua code to see how it works. The comments that begin with "SEE NOTE ..." refer to long explanations that follow the code. Sending ``function-name()`` means “invoke the Lua function.” The effect is that the string which the function returns will end up on the screen. Since this is a test, there are deliberate errors. The "golf club" and the "waffle iron" do not have numeric Quantity fields, so must be ignored. Therefore the real sum of the Quantity field in the JSON strings should be: 15 + 7 = 22. Since this is the grand finale, we will redo the final versions of all the necessary requests: the request that created ``string_function()``, the request that created ``main_function()``, and the request that invokes ``main_function()``. Start Tarantool, cut and paste the code for function ``indexed_pattern_search()``, and try the following: Sum a JSON field for all tuples The new line here is ``box.space.tester:replace(t)``. The name contains 'tester' because the insertion is going to be to tester. The second parameter is the tuple value. To be perfectly correct we could have said ``box.space.tester:insert(t)`` here, rather than ``box.space.tester:replace(t)``, but "replace" means “insert even if there is already a tuple whose primary-key value is a duplicate”, and that makes it easier to re-run the exercise even if the sandbox database isn't empty. Once this is done, tester will contain a tuple with two fields. The first field will be 1. The second field will be a random 10-letter string. Once again the ``string_function(``) can be invoked from ``main_function()`` which can be invoked with ``main_function()``. But ``main_function()`` won't tell the whole story, because it does not return t, it only puts t into the database. To confirm that something got inserted, we'll use a SELECT request. The purpose of the exercise is to show what Lua functions look like inside Tarantool. It will be necessary to employ the Lua math library, the Lua string library, the Tarantool box library, the Tarantool box.tuple library, loops, and concatenations. It should be easy to follow even for a person who has not used either Lua or Tarantool before. The only requirement is a knowledge of how other programming languages work and a memory of the first two chapters of this manual. But for better understanding, follow the comments and the links, which point to the Lua manual or to elsewhere in this Tarantool manual. To further enhance learning, type the statements in with the tarantool client while reading along. The result will be: The screen now looks like this: The standard Lua function `os.clock() <http://www.lua.org/manual/5.1/manual.html#pdf-os.clock>`_ will return the number of CPU seconds since the start. Therefore, by getting start_time = number of seconds just before the inserting, and then getting end_time = number of seconds just after the inserting, we can calculate (end_time - start_time) = elapsed time in seconds. We will display that value by putting it in a request without any assignments, which causes Tarantool to send the value to the client, which prints it. (Lua's answer to the C ``printf()`` function, which is ``print()``, will also work.) The word "``function``" is a Lua keyword -- we're about to go into Lua. The function name is string_function. The function has one executable statement, ``return "hello world"``. The string "hello world" is enclosed in double quotes here, although Lua doesn't care -- one could use single quotes instead. The word "``end``" means “this is the end of the Lua function declaration.” To confirm that the function works, we can say The words "for x = 1,10,1" mean “start with x equals 1, loop until x equals 10, increment x by 1 for each iteration.” The symbol ".." means "concatenate", that is, add the string on the right of the ".." sign to the string on the left of the ".." sign. Since we start by saying that random_string is "" (a blank string), the end result is that random_string has 10 random letters. Once again the ``string_function()`` can be invoked from ``main_function()`` which can be invoked with ``main_function()``. Then we assign a value to ``string_value``, namely, the result of ``string_function()``. Soon we will invoke ``main_function()`` to check that it got the value. This is an exercise assignment: “Assume that inside every tuple there is a string formatted as JSON. Inside that string there is a JSON numeric field. For each tuple, find the numeric field's value and add it to a 'sum' variable. At end, return the 'sum' variable.” The purpose of the exercise is to get experience in one way to read and process tuples. This is an exercise assignment: “Insert one million tuples. Each tuple should have a constantly-increasing numeric primary-key field and a random alphabetic 10-character string field.” We are going to use the Tarantool sandbox that was created for our :ref:`"Getting started" exercises <getting_started>`. So there is a single space, and a numeric primary key, and a running Tarantool server instance which also serves as a client. We begin by declaring a variable "``string_value``". The word "``local``" means that string_value appears only in ``main_function``. If we didn't use "``local``" then ``string_value`` would be visible everywhere - even by other users using other clients connected to this server instance! Sometimes that's a very desirable feature for inter-client communication, but not this time. We will start by making a function that returns a fixed string, “Hello world”. What has also been shown is that inserting a million tuples took 37 seconds. The host computer was a Linux laptop. By changing :ref:`wal_mode <cfg_binary_logging_snapshots-wal_mode>` to 'none' before running the test, one can reduce the elapsed time to 4 seconds. What has been shown is that Lua functions are quite expressive (in fact one can do more with Tarantool's Lua stored procedures than one can do with stored procedures in some SQL DBMSs), and that it's straightforward to combine Lua-library functions and Tarantool-library functions. box.space.t:drop()
box.schema.space.create('t')
box.space.t:create_index('primary',{})
box.space.t:create_index('secondary',{unique=false,parts={2,'string',3,'string'}})
box.space.t:insert{1,'A','a'}
box.space.t:insert{2,'AB',''}
box.space.t:insert{3,'ABC','a'}
box.space.t:insert{4,'ABCD',''}
box.space.t:insert{5,'ABCDE','a'}
box.space.t:insert{6,'ABCDE',''}
box.space.t:insert{7,'ABCDEF','a'}
box.space.t:insert{8,'ABCDF',''}
indexed_pattern_search("t", 2, "ABC.E.") box.space.tester:insert{444, '{"Item": "widget", "Quantity": 15}'}
box.space.tester:insert{445, '{"Item": "widget", "Quantity": 7}'}
box.space.tester:insert{446, '{"Item": "golf club", "Quantity": "sunshine"}'}
box.space.tester:insert{447, '{"Item": "waffle iron", "Quantit": 3}'} field[1]: 444
field[2]: '{"Hello": "world", "Quantity": 15}' function indexed_pattern_search(space_name, field_no, pattern)
  -- SEE NOTE #1 "FIND AN APPROPRIATE INDEX"
  if (box.space[space_name] == nil) then
    print("Error: Failed to find the specified space")
    return nil
  end
  local index_no = -1
  for i=0,box.schema.INDEX_MAX,1 do
    if (box.space[space_name].index[i] == nil) then break end
    if (box.space[space_name].index[i].type == "TREE"
        and box.space[space_name].index[i].parts[1].fieldno == field_no
        and (box.space[space_name].index[i].parts[1].type == "scalar"
        or box.space[space_name].index[i].parts[1].type == "string")) then
      index_no = i
      break
    end
  end
  if (index_no == -1) then
    print("Error: Failed to find an appropriate index")
    return nil
  end
  -- SEE NOTE #2 "DERIVE INDEX SEARCH KEY FROM PATTERN"
  local index_search_key = ""
  local index_search_key_length = 0
  local last_character = ""
  local c = ""
  local c2 = ""
  for i=1,string.len(pattern),1 do
    c = string.sub(pattern, i, i)
    if (last_character ~= "%") then
      if (c == '^' or c == "$" or c == "(" or c == ")" or c == "."
                   or c == "[" or c == "]" or c == "*" or c == "+"
                   or c == "-" or c == "?") then
        break
      end
      if (c == "%") then
        c2 = string.sub(pattern, i + 1, i + 1)
        if (string.match(c2, "%p") == nil) then break end
        index_search_key = index_search_key .. c2
      else
        index_search_key = index_search_key .. c
      end
    end
    last_character = c
  end
  index_search_key_length = string.len(index_search_key)
  if (index_search_key_length < 3) then
    print("Error: index search key " .. index_search_key .. " is too short")
    return nil
  end
  -- SEE NOTE #3 "OUTER LOOP: INITIATE"
  local result_set = {}
  local number_of_tuples_in_result_set = 0
  local previous_tuple_field = ""
  while true do
    local number_of_tuples_since_last_yield = 0
    local is_time_for_a_yield = false
    -- SEE NOTE #4 "INNER LOOP: ITERATOR"
    for _,tuple in box.space[space_name].index[index_no]:
    pairs(index_search_key,{iterator = box.index.GE}) do
      -- SEE NOTE #5 "INNER LOOP: BREAK IF INDEX KEY IS TOO GREAT"
      if (string.sub(tuple[field_no], 1, index_search_key_length)
      > index_search_key) then
        break
      end
      -- SEE NOTE #6 "INNER LOOP: BREAK AFTER EVERY 10 TUPLES -- MAYBE"
      number_of_tuples_since_last_yield = number_of_tuples_since_last_yield + 1
      if (number_of_tuples_since_last_yield >= 10
          and tuple[field_no] ~= previous_tuple_field) then
        index_search_key = tuple[field_no]
        is_time_for_a_yield = true
        break
        end
      previous_tuple_field = tuple[field_no]
      -- SEE NOTE #7 "INNER LOOP: ADD TO RESULT SET IF PATTERN MATCHES"
      if (string.match(tuple[field_no], pattern) ~= nil) then
        number_of_tuples_in_result_set = number_of_tuples_in_result_set + 1
        result_set[number_of_tuples_in_result_set] = tuple
      end
    end
    -- SEE NOTE #8 "OUTER LOOP: BREAK, OR YIELD AND CONTINUE"
    if (is_time_for_a_yield ~= true) then
      break
    end
    require('fiber').yield()
  end
  return result_set
end function main_function()
  local string_value
  string_value = string_function()
  return string_value
end function main_function()
  local string_value, t
  for i = 1,1000000,1 do
    string_value = string_function()
    t = box.tuple.new({i,string_value})
    box.space.tester:replace(t)
  end
end
start_time = os.clock()
main_function()
end_time = os.clock()
'insert done in ' .. end_time - start_time .. ' seconds' function main_function()
  local string_value, t
  string_value = string_function()
  t = box.tuple.new({1, string_value})
  return t
end function main_function()
  local string_value, t
  string_value = string_function()
  t = box.tuple.new({1,string_value})
  box.space.tester:replace(t)
end function string_function()
  local random_number
  local random_string
  random_number = math.random(65, 90)
  random_string = string.char(random_number)
  return random_string
end function string_function()
  local random_number
  local random_string
  random_string = ""
  for x = 1,10,1 do
    random_number = math.random(65, 90)
    random_string = random_string .. string.char(random_number)
  end
  return random_string
end function string_function()
  local random_number
  local random_string
  random_string = ""
  for x = 1,10,1 do
    random_number = math.random(65, 90)
    random_string = random_string .. string.char(random_number)
  end
  return random_string
end

function main_function()
  local string_value, t
  for i = 1,1000000,1 do
    string_value = string_function()
    t = box.tuple.new({i,string_value})
    box.space.tester:replace(t)
  end
end
start_time = os.clock()
main_function()
end_time = os.clock()
'insert done in ' .. end_time - start_time .. ' seconds' function string_function()
  return "hello world"
end json = require('json')
function sum_json_field(field_name)
  local v, t, sum, field_value, is_valid_json, lua_table
  sum = 0
  for v, t in box.space.tester:pairs() do
    is_valid_json, lua_table = pcall(json.decode, t[2])
    if is_valid_json then
      field_value = lua_table[field_name]
      if type(field_value) == "number" then sum = sum + field_value end
    end
  end
  return sum
end main_function()
box.space.tester:select{1} meaning that the tuple's first field, the primary key field, is a number while the tuple's second field, the JSON string, is a string. Thus the entire statement means "decode ``t[2]`` (the tuple's second field) as a JSON string; if there's an error set ``is_valid_json = false``; if there's no error set ``is_valid_json = true`` and set ``lua_table =`` a Lua table which has the decoded string". string_function() tarantool> function main_function()
         >   local string_value
         >   string_value = string_function()
         >   return string_value
         > end
---
...
tarantool> main_function()
---
- hello world
...
tarantool> tarantool> function main_function()
         >   local string_value, t
         >   string_value = string_function()
         >   t = box.tuple.new({1,string_value})
         >   box.space.tester:replace(t)
         > end
---
...
tarantool> main_function()
---
...
tarantool> box.space.tester:select{1}
---
- - [1, 'EUJYVEECIL']
...
tarantool> tarantool> function main_function()
         > local string_value, t
         > string_value = string_function()
         > t = box.tuple.new({1, string_value})
         > return t
         > end
---
...
tarantool> main_function()
---
- [1, 'PNPZPCOOKA']
...
tarantool> tarantool> function string_function()
         >   local random_number
         >   local random_string
         >   random_number = math.random(65, 90)
         >   random_string = string.char(random_number)
         >   return random_string
         > end
---
...
tarantool> main_function()
---
- C
...
tarantool> tarantool> function string_function()
         >   local random_number
         >   local random_string
         >   random_string = ""
         >   for x = 1,10,1 do
         >     random_number = math.random(65, 90)
         >     random_string = random_string .. string.char(random_number)
         >   end
         >   return random_string
         > end
---
...
tarantool> function main_function()
         >   local string_value, t
         >   for i = 1,1000000,1 do
         >     string_value = string_function()
         >     t = box.tuple.new({i,string_value})
         >     box.space.tester:replace(t)
         >   end
         > end
---
...
tarantool> start_time = os.clock()
---
...
tarantool> main_function()
---
...
tarantool> end_time = os.clock()
---
...
tarantool> 'insert done in ' .. end_time - start_time .. ' seconds'
---
- insert done in 37.62 seconds
...
tarantool> tarantool> function string_function()
         >   local random_number
         >   local random_string
         >   random_string = ""
         >   for x = 1,10,1 do
         >     random_number = math.random(65, 90)
         >     random_string = random_string .. string.char(random_number)
         >   end
         >   return random_string
         > end
---
...
tarantool> main_function()
---
- 'ZUDJBHKEFM'
...
tarantool> tarantool> function string_function()
         >   return "hello world"
         > end
---
...
tarantool> string_function()
---
- hello world
...
tarantool> tarantool> indexed_pattern_search("t", 2, "ABC.E.")
---
- - [7, 'ABCDEF', 'a']
... tarantool> sum_json_field("Quantity")
---
- 22
... then add some tuples where the first field is a number and the second field is a string. Project-Id-Version: Tarantool 1.10
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2020-02-03 19:10+0000
PO-Revision-Date: 2019-10-23 18:45+0400
Last-Translator: 
Language: ru
Language-Team: 
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.8.0
 **СТРОКА 3: ЗАЧЕМ НУЖЕН "LOCAL".** Эта строка объявляет все переменные, которые будут использоваться в функции. На самом деле, нет необходимости в начале объявлять все переменные, а в длинной функции лучше объявить переменные прямо перед их использованием. Фактически объявлять переменные вообще необязательно, но необъявленная переменная будет "глобальной". Это представляется нежелательным для всех переменных, объявленных в строке 1, поскольку все они используются только в рамках функции. **СТРОКА 5: НАЧАЛО ОСНОВНОГО ЦИКЛА.** Всё внутри цикла "``for``" будет повторяться до тех пор, пока не кончатся индекс-ключи. На полученный кортеж можно сослаться с помощью переменной :code:`t`. **СТРОКА 5: ЗАЧЕМ НУЖЕН "PAIRS()".** Наша задача -- пройти по всем строкам, что можно сделать двумя способами: с помощью :ref:`box.space.space_object:pairs() <box_space-pairs>` или с помощью ``variable = select(...)`` с указанием :samp:`for i, {n}, 1 do {некая-функция}(variable[i]) end`. Для данного примера мы предпочли использовать ``pairs()``. **СТРОКА 6: ЗНАЧЕНИЕ.** Функция :ref:`json.decode <json-decode>` означает декодирование JSON-строки, а параметр t[2] представляет собой ссылку на JSON-строку. Здесь есть заранее заданные значения, а мы предполагаем, что JSON-строка была вставлена во второе поле кортежа. Например, предположим, что кортеж выглядит следующим образом: **СТРОКА 6: ЗАЧЕМ НУЖЕН "PCALL".** Если бы мы просто ввели ``lua_table = json.decode(t[2]))``, то функция завершила бы работу с ошибкой, обнаружив любое несоответствие в JSON-строке, например отсутствие запятой. Заключив функцию в "``pcall``" (`protected call`_ -- защищенный вызов), мы заявляем следующее: хотим перехватывать ошибки такого рода, поэтому в случае ошибки следует просто указать ``is_valid_json = false``, и позднее мы решим, что с этим делать. **СТРОКА 8.** Наконец, мы готовы получить значение JSON-поля из Lua-таблицы, взятое из JSON-строки. Значение в field_name (имя_поля), которое является параметром всей функции, должно представлять собой JSON-поле. Например, в JSON-строке ``'{"Hello": "world", "Quantity": 15}'`` есть два JSON-поля: "Hello" и "Quantity". Если вся функция вызывается с помощью ``sum_json_field("Quantity")``, тогда ``field_value = lua_table[field_name]`` (значение_поля = Lua_таблица[имя_поля]) по сути аналогично ``field_value = lua_table["Quantity"]`` или даже ``field_value = lua_table.Quantity``. Итак, этими тремя способами можно ввести следующую команду: получить значение поля Quantity в Lua-таблице и поместить его в переменную :code:`field_value`. **СТРОКА 9: ЗАЧЕМ НУЖЕН "IF".** Предположим, что JSON-строка не содержит синтаксических ошибок, но JSON-поле не является числовым или вовсе отсутствует. В таком случае выполнение функции прервется при попытке прибавить значение к сумме. Если сначала проверить, ``type(field_value) == "number"`` (тип(значение_поля) == "число"), можно избежать прерывания функции. Если вы уверены, что база данных в идеальном состоянии, этот шаг можно пропустить. -- если спейс tester остался от предыдущего задания, удалите его
box.space.tester:drop()
box.schema.space.create('tester')
box.space.tester:create_index('primary', {parts = {1, 'unsigned'}}) ... На самом деле, вывод не всегда будет именно таким, поскольку функция ``math.random()`` вызывает случайные числа. Но для наглядности случайные значения в строке не важны. :ref:`Индексированный поиск по шаблонам <c_lua_tutorial-indexed_pattern_search>`. :ref:`Вставка 1 млн кортежей с помощью хранимой процедуры на языке Lua <c_lua_tutorial-insert_one_million_tuples>`, :ref:`Подсчет суммы по JSON-полям во всех кортежах <c_lua_tutorial-sum_a_json_field>`, И функция готова. Пора протестировать ее. Начинаем с пустой базы данных так же, как с песочницы в :ref:`упражнения в "Руководстве для начинающих" <getting_started>`, Настройка Создание функции, которая вызывает другую функцию и определяет переменную Создание функции, которая возвращает строку Разделитель ПРИМЕР: Для получения подробной информации о циклах в языке Lua, см. Главу 4.3.4 "Числовой оператор for" в руководстве по языку Lua (`chapter 4.3.4 "Numeric for"`_). Для получения подробной информации о функциях математической библиотеки в языке Lua, см. Практическое задание по математической библиотеке для пользователей Lua (`Math Library Tutorial`_). Для получения подробной информации о функциях библиотеки для работы со строками в языке Lua, см.  Практическое задание по библиотеке для работы со строками для пользователей Lua (`String Library Tutorial`_). Для получения подробной информации о строках в языке Lua, см.  `Главу 2.4 "Строки"`_ в руководстве по языку Lua. Для получения подробной информации о функциях см. Главу 5 "Функции" в руководстве по языку Lua (`chapter 5 "Functions"`_). Для получения подробной информации о переменных в языке Lua, см. Главу 4.2 "Локальные переменные и блоки" в руководстве по языку Lua (`chapter 4.2 "Local Variables and Blocks"`_). Для получения подробной информации о вызовах insert и replace в Tarantool'е, см. разделы :ref:`Вложенный модуль box.space <box_space>`, :ref:`space_object:insert() <box_space-insert>` и :ref:`space_object:replace() <box_space-replace>` руководства по Tarantool'у. Для получения подробной информации о кортежах в Tarantool'е, см. раздел :ref:`Вложенный модуль box.tuple <box_tuple>` руководства по Tarantool'у. Для получения подробной информации о функции ``os.clock()`` см. Главу 22.1 "Дата и время" в руководстве по языку Lua (`chapter 22.1 "Date and Time"`_). Для получения подробной информации о функции print() см. Главу 5 "Функции" в руководстве по языку Lua (`chapter 5 "Functions"`_). Практические задания по использованию хранимых процедур на языке Lua в работе с Tarantool'ом: Здесь приведена обобщенная функция, которая берет идентификатор поля и шаблон поиска, а затем возвращает все кортежи, которые подходят под критерии. |br| * Поле должно быть первым полем в TREE-индексе. |br| * Функция применяет `шаблоны в языке Lua <http://www.lua.org/manual/5.2/manual.html#6.4.1>`_, что позволяет использовать "магические символы" в регулярных выражениях. |br| * Начальные символы в шаблоне до самого первого магического символа будут использоваться в качестве ключа поиска по индексу. Каждый кортеж, обнаруженный по индексу, будет соответствовать всему шаблону. |br| * В целях :ref:`кооперативной многозадачности <atomic-cooperative_multitasking>` функция должна передавать управление через каждые 10 кортежей, если только нет причин отложить передачу управления. |br| С помощью данной функции можно воспользоваться индексами Tarantool'а для ускорения и шаблонами на языке Lua для гибкости. Поддерживаются все возможности поиска LIKE в SQL -- и многие другие. В более ранних версиях Tarantool'а многострочные функции обрамляются символами-разделителями. Сейчас в них нет необходимости, поэтому в данном практическом задании они использоваться не будут. Однако они все еще поддерживаются. Если вы хотите использовать разделители или используете более раннюю версию Tarantool'а, перед работой проверьте описание синтаксиса для :ref:`объявления разделителя <console-delimiter>`. Индексированный поиск по шаблонам Вставка 1 млн кортежей с помощью хранимой процедуры на языке Lua Вызовите функцию с помощью ``sum_json_field("Quantity")``. Нет необходимости стирать содержание старой функции ``string_function()``, оно просто перезаписывается. Первый оператор вызывает функцию из математической библиотеки Lua, которая возвращает случайное число; параметры означают, что число должно быть целым от 65 до 90. Второй оператор вызывает функцию из библиотеки Lua для работы со строками, которая преобразует число в символ; параметр представляет собой кодовую точку символа. К счастью, в кодировке ASCII символу 'A' соответствует значение 65, а 'Z' -- 90, так что в результате всегда получим букву от A до Z. Сработало. Для дополнительной отработки материала можно убрать заранее заданные значения, добавить проверку потенциально возможного арифметического переполнения при наличии больших значений некоторых полей, а также команду :ref:`передачи управления <atomic-threads_fibers_yields>` при огромном количестве кортежей. Практические задания на Lua Составление кортежа из числа и строки Изменение основной функции main_function для вставки миллиона кортежей в базу данных Изменение основной функции main_function для вставки кортежа в базу данных Изменение функции для возврата строки из одной случайной буквы Изменение функции для возврата строки из десяти случайных букв ПРИМЕЧАНИЕ №1 "ПОИСК НУЖНОГО ИНДЕКСА" |br| Вызывающий клиент передал space_name (имя_спейса -- строка) и field_no (номер_поля -- число). Требования следующие: |br| (a) тип индекса должен быть "TREE", поскольку для других типов индекса (HASH, BITSET, RTREE) поиск с :ref:`итератором=GE <box_index-iterator-types>` не вернет строки, упорядоченные по строковому значению; |br| (b) field_no должен представлять собой первую часть индекса; |br| (c) поле должно содержать строки, потому что для других типов данных (как "unsigned") шаблоны поиска не применяются; |br| Если индекс не удовлетворяет этим требованиям, выдать сообщение об ошибке и вернуть нулевое значение nil. ПРИМЕЧАНИЕ №2 "ПОЛУЧЕНИЕ КЛЮЧА ИНДЕКСНОГО ПОИСКА ИЗ ШАБЛОНА" |br| Вызывающий клиент передал шаблон (строку). Ключом поиска по индексу являются символы в шаблоне до первого магического символа. Магические символы в Lua: % ^ $ ( ) . [ ] * + - ?. Например, если задан шаблон "ABC.E", точка будет магическим символом, и ключом поиска по индексу будет "ABC". Однако есть затруднение ... Если символ "%" будет идти следом за знаком препинания, этот знак препинания экранируется, поэтому следует убрать "%" из ключа поиска по индексу. Например, если задан шаблон "AB%$E", знак доллара экранируется, поэтому ключом поиска по индексу будет "AB$E". Наконец, есть проверка длины ключа поиска по индексу -- не менее трех символов, причем это число выбрано произвольно, и даже ноль здесь подойдет, но по короткому ключу поиск займет длительное время. ПРИМЕЧАНИЕ №3 "ВНЕШНИЙ ЦИКЛ: НАЧАЛО" |br| Назначение функции -- вернуть результирующий набор данных, как вернул бы запрос `box.space...select <box_space-select>`. Мы внесем ее во внешний цикл, который включает в себя внутренний цикл. Назначение внешнего цикла -- выполнять внутренний цикл и, при необходимости, :ref:`передачу управления <atomic-threads_fibers_yields>`, пока поиск не будет завершен. Назначение внутреннего цикла -- находить кортежи по индексу и включать их в результирующий набор данных, если они подходят под шаблон. ПРИМЕЧАНИЕ №4 "ВНУТРЕННИЙ ЦИКЛ: ИТЕРАТОР" |br| Цикл for здесь использует pairs(), см. :ref:`объяснение, что такое итераторы <box_index-index_pairs>`. Во внутреннем цикле будет локальная переменная под названием "tuple" (кортеж), которая содержит последний кортеж, обнаруженный в ходе поиска по индексу. ПРИМЕЧАНИЕ №5 "ВНУТРЕННИЙ ЦИКЛ: ПРЕРЫВАНИЕ, ЕСЛИ КЛЮЧ ИНДЕКСА СЛИШКОМ БОЛЬШОЙ" |br| Используется итератор GE (Greater or Equal - больше или равно), поэтому необходимо уточнить: если ключ поиска по индексу включает в себя N символов, то крайние N символов слева от найденного поля индекса не должны быть больше ключа поиска. Например, если ключом поиска является  'ABC', то 'ABCDE' потенциально подходит, а 'ABD' означает, что в дальнейшем совпадений не будет. ПРИМЕЧАНИЕ №6 "ВНУТРЕННИЙ ЦИКЛ: ПРЕРЫВАНИЕ ПОСЛЕ КАЖДЫХ ДЕСЯТИ КОРТЕЖЕЙ -- ВОЗМОЖНО" |br| Эта часть кода предназначена для кооперативной многозадачности. Число 10 выбрано произвольно, и как правило, большее число также подойдет. Простое правило гласит: "после проверки 10 кортежей передать управление, а затем возобновить поиск (то есть снова выполнять внутренний цикл), начиная с последнего обнаруженного значения". Однако, если индекс не уникален, или в индексе более одного поля, можно получить дублирующиеся результаты, например, {"ABC",1}, {"ABC", 2}, {"ABC", 3}" -- и будет трудно решить, с какого кортежа "ABC" возобновлять поиск. Таким образом, если найденное поле индекса совпадает с предыдущим найденным полем индекса, цикл не прерывается. ПРИМЕЧАНИЕ №7 "ВНУТРЕННИЙ ЦИКЛ: ДОБАВЛЕНИЕ В РЕЗУЛЬТАТ, ЕСЛИ ШАБЛОН СОВПАДЕТ" |br| Сравнение найденного поля индекса с шаблоном. Например, предположим, что вызывающий клиент передает шаблон "ABC.E", и существует поле индекса, содержащее "ABCDE". В таком случае, начальный ключ поиска будет "ABC". Таким образом, кортеж, содержащий поле индекса с "ABCDE" будет обнаружен итератором, поскольку "ABCDE" > "ABC". В этом случае, string.match вернет значение, отличное от нулевого nil. В итоге, этот кортеж можно добавить в результирующий набор данных. ПРИМЕЧАНИЕ №8 "ВНЕШНИЙ ЦИКЛ: ПРЕРЫВАНИЕ ИЛИ ПЕРЕДАЧА УПРАВЛЕНИЯ И ПРОДОЛЖЕНИЕ" |br| Существуют три условия, которые вызовут прерывание из внутреннего цикла: (1) цикл for заканчивается закономерно, потому что отсутствуют ключи индекса, которые больше или равны ключу поиска по индексу, (2) ключ индекса слишком большой, как описано в ПРИМЕЧАНИИ №5, (3) пора передавать управление, как описано в ПРИМЕЧАНИИ №6. Если условие (1) или условие (2) соблюдается, другие действия не требуются, и внешний цикл также заканчивается. Только в том случае, если справедливо условие (3), внешний цикл должен передать управление, а затем продолжить выполнение. Если он продолжит выполнение, то внутренний цикл -- поиск с итератором -- будет выполняться снова с новым значением для ключа поиска по индексу. Теперь у нас есть функция ``string_function``, и можно вызвать ее с помощью другой функции. Сейчас стало понятно, как задавать переменную, поэтому можно изменить функцию ``string_function()`` так, чтобы вместо возврата заданной фразы "Hello world", она возвращала случайным образом выбранную букву от 'A' до 'Z'. Сейчас стало понятно, как вставить кортеж в базу данных, поэтому несложно догадаться, как можно увеличить масштаб: вместо того, чтобы вставлять значение 1 для первичного ключа, вставьте значение переменной от 1 до миллиона в цикле. Поскольку уже рассматривалось, как заводить цикл, это будет несложно. Мы лишь добавим небольшой штрих -- функцию распределения во времени. Сейчас стало понятно, как создать строку из 10 случайных букв, поэтому можно создать кортеж, который будет содержать число и строку из 10 случайных букв, с помощью функции в Tarantool-библиотеке Lua-функций. Сейчас стало понятно, как создавать кортеж, который содержит число и строку из десяти случайных букв, поэтому осталось только поместить этот кортеж в спейс tester. Следует отметить, что tester -- это первый спейс, определенный в песочнице, поэтому он представляет собой таблицу в базе данных. Сейчас стало понятно, как вызывать строки из одной случайной буквы, поэтому можно перейти к нашей цели -- возврату строки из десяти букв с помощью конкатенации десяти строк из одной случайной буквы в цикле. И снова функцию ``string_function()`` можно вызвать из main_function(), которую можно вызвать с помощью ``main_function()``. После этого, "t" будет представлять собой значение нового кортежа с двумя полями. Первое поле является числовым: "1". Второе поле представляет собой случайную строку. И снова функцию ``string_function()`` можно вызвать из ``main_function()``, которую можно вызвать с помощью ``main_function()``. Прочитайте следующий Lua-код, чтобы понять, как он работает. Комментарии, которые начинаются с "СМ. ПРИМЕЧАНИЕ ..." ссылаются на подробные объяснения, приведенные ниже. Отправка ``function-name()`` (имя-функции) означает команду вызова Lua-функции. В результате возвращаемая функцией строка появится на экране. Для целей практики здесь допущены ошибки. В "golf club" и "waffle iron" поля Quantity не являются числовыми, поэтому будут игнорироваться. Таким образом, итоговая сумма для полей Quantity в JSON-строках должна быть следующей: 15 + 7 = 22. И поскольку наступает кульминация -- повторно введем окончательные варианты всех необходимых запросов: запрос, который создает ``string_function()``, запрос, который создает ``main_function()``, и запрос, который вызывает ``main_function()``. Запустите Tarantool, скопируйте и вставьте код для функции ``indexed_pattern_search()`` и попробуйте выполнить следующее: Подсчет суммы по JSON-полям во всех кортежах Здесь новая строка -- ``box.space.tester:replace(t)``. Имя содержит слово 'tester', потому что вставка будет осуществляться в спейс tester. Второй параметр представляет собой значение в кортеже. Для абсолютной точности мы могли ввести команду ``box.space.tester:insert(t)``, а не ``box.space.tester:replace(t)``, но слово "replace" (заменить) означает “вставить, даже если уже существует кортеж, у которого значение первичного ключа совпадает”, и это облегчит повтор упражнения, даже если песочница не пуста. После того, как это будет выполнено, спейс tester будет содержать кортеж с двумя полями. Первое поле будет 1. Второе поле будет представлять собой строку из десяти случайных букв. И снова функцию ``string_function()`` можно вызвать из ``main_function()``, которую можно вызвать с помощью ``main_function()``. Но функция ``main_function()`` не может полностью отразить ситуацию, поскольку она не возвращает t, она только размещает t в базе данных. Чтобы убедиться, что произошла вставка, используем SELECT-запрос. Цель данного упражнения состоит в том, чтобы показать, как выглядят Lua-функции в Tarantool'е. Необходимо будет работать с математической библиотекой Lua, библиотекой для работы со строками интерпретатора Lua, Tarantool-библиотекой ``box``, Tarantool-библиотекой ``box.tuple``, циклами и конкатенацией. Инструкции легко будет выполнять даже тем, кто никогда не использовал раньше Lua или Tarantool. Единственное требование -- знание того, как работают другие языки программирования, и изучение первых двух глав данного руководства. Но для лучшего понимания можно следовать по комментариям и ссылкам на руководство по Lua или другим пунктам в данном руководстве по Tarantool'у. А чтобы облегчить изучение, читайте инструкции параллельно с вводом операторов в Tarantool-клиент. Получим следующий результат: Теперь вывод на экране выглядит следующим образом: Стандартная Lua-функция `os.clock() <http://www.lua.org/manual/5.1/manual.html#pdf-os.clock>`_ вернет время ЦП в секундах с момента начала программы. Таким образом, выводя start_time = number of seconds (время_начала = число секунд) прямо перед вставкой, а затем выводя end_time = number of seconds (время_окончания = число секунд) сразу после вставки, можно рассчитать (время_окончания - время_начала) = затраченное время в секундах. Отобразим это значение путем ввода в запрос без операторов, что приведет к тому, что Tarantool отправит значение на клиент, который выведет это значение. (Ответ Lua на C-функцию ``printf()``, а именно ``print()``, также сработает.) Слово "``function``" (функция) -- ключевое слово в языке Lua. Рассмотрим подробно работу с языком Lua. Имя функции -- string_function (строковая_функция). В функции есть один исполняемый оператор, ``return "hello world"`` (вернуть "hello world"). Строка "hello world" здесь заключена в двойные кавычки, хотя в Lua это не имеет значения, можно использовать одинарные кавычки. Слово "``end``" означает, что “это конец объявления Lua-функции.” Чтобы проверить работу функции, можем выполнить команду Слова "for x = 1,10,1" означают: “начать с x, равного 1, зацикливать до тех пор, пока x не будет равен 10, увеличивать x на 1 на каждом шаге цикла”. Символ ".." означает "конкатенацию", то есть добавление строки справа от знака ".." к строке слева от знака "..". Поскольку в начале определяется, что random_string (случайная_строка) представляет собой "" (пустую строку), в результате получим, что в random_string 10 случайных букв. И снова функцию ``string_function()`` можно вызвать из ``main_function()``, которую можно вызвать с помощью ``main_function()``. Затем определим значение для ``string_value``, а именно, результат функции ``string_function()``. Сейчас вызовем ``main_function()``, чтобы проверить, что значение определено. Задание по данному практикуму: “Предположим, что в каждом кортеже есть строка в формате JSON. В каждой строке есть числовое поле формата JSON. Для каждого кортежа необходимо найти значение числового поля и прибавить его к переменной 'sum' (сумма). В конце функция должна вернуть переменную 'sum'.” Цель данного упражнения -- получить опыт в прочтении и обработке кортежей одновременно. Задание по данному практикуму: “Вставьте 1 миллион кортежей. В каждом кортеже должно быть поле, которое соответствует ключу в первичном индексе, в виде постоянно возрастающего числа, а также поле в виде буквенной строки со случайным значением из 10 символов.” Будем использовать Tarantool-песочницу, которую создавали для :ref:`упражнений раздела "Руководство для начинающих" <getting_started>`. Таким образом, у нас есть один спейс и числовой ключ первичного индекса, а также экземпляр Tarantool'а, который также выступает в виде клиента. Сначала объявим переменную "``string_value``" (значение_строки). Слово "``local``" (локально) означает, что string_value появится только в ``main_function`` (основная_функция). Если бы мы не использовали "``local``", то ``string_value`` увидели бы даже пользователи других клиентов, которые подключились к данному экземпляру! Иногда это может быть очень полезно при взаимодействии клиентов, но не в нашем случае. Начнем с создания функции, которая возвращает заданную строку -- “Hello world”. Также мы показали, что вставка миллиона кортежей заняла 37 секунд. Хостом выступил ноутбук с ОС Linux. А изменив значение  :ref:`wal_mode <cfg_binary_logging_snapshots-wal_mode>` на 'none' перед запуском теста, можно уменьшить затраченное время до 4 секунд. Итак, мы доказали, что возможности Lua-функций довольно многообразны (на самом деле, с помощью хранимых процедур на языке Lua в Tarantool'е можно сделать больше, чем с помощью хранимых процедур в некоторых SQL СУБД), и несложно комбинировать функции Lua-библиотек и функции Tarantool-библиотек. box.space.t:drop()
box.schema.space.create('t')
box.space.t:create_index('primary',{})
box.space.t:create_index('secondary',{unique=false,parts={2,'string',3,'string'}})
box.space.t:insert{1,'A','a'}
box.space.t:insert{2,'AB',''}
box.space.t:insert{3,'ABC','a'}
box.space.t:insert{4,'ABCD',''}
box.space.t:insert{5,'ABCDE','a'}
box.space.t:insert{6,'ABCDE',''}
box.space.t:insert{7,'ABCDEF','a'}
box.space.t:insert{8,'ABCDF',''}
indexed_pattern_search("t", 2, "ABC.E.") box.space.tester:insert{444, '{"Item": "widget", "Quantity": 15}'}
box.space.tester:insert{445, '{"Item": "widget", "Quantity": 7}'}
box.space.tester:insert{446, '{"Item": "golf club", "Quantity": "sunshine"}'}
box.space.tester:insert{447, '{"Item": "waffle iron", "Quantit": 3}'} field[1]: 444
field[2]: '{"Hello": "world", "Quantity": 15}' function indexed_pattern_search(space_name, field_no, pattern)
  -- СМ. ПРИМЕЧАНИЕ №1 "ПОИСК НУЖНОГО ИНДЕКСА"
  if (box.space[space_name] == nil) then
    print("Error: Failed to find the specified space")
    return nil
  end
  local index_no = -1
  for i=0,box.schema.INDEX_MAX,1 do
    if (box.space[space_name].index[i] == nil) then break end
    if (box.space[space_name].index[i].type == "TREE"
        and box.space[space_name].index[i].parts[1].fieldno == field_no
        and (box.space[space_name].index[i].parts[1].type == "scalar"
        or box.space[space_name].index[i].parts[1].type == "string")) then
      index_no = i
      break
    end
  end
  if (index_no == -1) then
    print("Error: Failed to find an appropriate index")
    return nil
  end
  -- СМ. ПРИМЕЧАНИЕ №2 "ПОЛУЧЕНИЕ КЛЮЧА ИНДЕКСНОГО ПОИСКА ИЗ ШАБЛОНА"
  local index_search_key = ""
  local index_search_key_length = 0
  local last_character = ""
  local c = ""
  local c2 = ""
  for i=1,string.len(pattern),1 do
    c = string.sub(pattern, i, i)
    if (last_character ~= "%") then
      if (c == '^' or c == "$" or c == "(" or c == ")" or c == "."
                   or c == "[" or c == "]" or c == "*" or c == "+"
                   or c == "-" or c == "?") then
        break
      end
      if (c == "%") then
        c2 = string.sub(pattern, i + 1, i + 1)
        if (string.match(c2, "%p") == nil) then break end
        index_search_key = index_search_key .. c2
      else
        index_search_key = index_search_key .. c
      end
    end
    last_character = c
  end
  index_search_key_length = string.len(index_search_key)
  if (index_search_key_length < 3) then
    print("Error: index search key " .. index_search_key .. " is too short")
    return nil
  end
  -- СМ. ПРИМЕЧАНИЕ №3 "ВНЕШНИЙ ЦИКЛ: НАЧАЛО"
  local result_set = {}
  local number_of_tuples_in_result_set = 0
  local previous_tuple_field = ""
  while true do
    local number_of_tuples_since_last_yield = 0
    local is_time_for_a_yield = false
    -- СМ. ПРИМЕЧАНИЕ №4 "ВНУТРЕННИЙ ЦИКЛ: ИТЕРАТОР"
    for _,tuple in box.space[space_name].index[index_no]:
    pairs(index_search_key,{iterator = box.index.GE}) do
      -- СМ. ПРИМЕЧАНИЕ №5 "ВНУТРЕННИЙ ЦИКЛ: ПРЕРЫВАНИЕ, ЕСЛИ КЛЮЧ ИНДЕКСА СЛИШКОМ БОЛЬШОЙ"
      if (string.sub(tuple[field_no], 1, index_search_key_length)
      > index_search_key) then
        break
      end
      -- СМ. ПРИМЕЧАНИЕ №6 "ВНУТРЕННИЙ ЦИКЛ: ПРЕРЫВАНИЕ ПОСЛЕ КАЖДЫХ ДЕСЯТИ КОРТЕЖЕЙ -- ВОЗМОЖНО"
      number_of_tuples_since_last_yield = number_of_tuples_since_last_yield + 1
      if (number_of_tuples_since_last_yield >= 10
          and tuple[field_no] ~= previous_tuple_field) then
        index_search_key = tuple[field_no]
        is_time_for_a_yield = true
        break
        end
      previous_tuple_field = tuple[field_no]
      -- СМ. ПРИМЕЧАНИЕ №7 "ВНУТРЕННИЙ ЦИКЛ: ДОБАВЛЕНИЕ В РЕЗУЛЬТАТ, ЕСЛИ ШАБЛОН СОВПАДЕТ"
      if (string.match(tuple[field_no], pattern) ~= nil) then
        number_of_tuples_in_result_set = number_of_tuples_in_result_set + 1
        result_set[number_of_tuples_in_result_set] = tuple
      end
    end
    -- СМ. ПРИМЕЧАНИЕ №8 "ВНЕШНИЙ ЦИКЛ: ПРЕРЫВАНИЕ ИЛИ ПЕРЕДАЧА УПРАВЛЕНИЯ И ПРОДОЛЖЕНИЕ"
    if (is_time_for_a_yield ~= true) then
      break
    end
    require('fiber').yield()
  end
  return result_set
end function main_function()
  local string_value
  string_value = string_function()
  return string_value
end function main_function()
  local string_value, t
  for i = 1,1000000,1 do
    string_value = string_function()
    t = box.tuple.new({i,string_value})
    box.space.tester:replace(t)
  end
end
start_time = os.clock()
main_function()
end_time = os.clock()
'insert done in ' .. end_time - start_time .. ' seconds' function main_function()
  local string_value, t
  string_value = string_function()
  t = box.tuple.new({1, string_value})
  return t
end function main_function()
  local string_value, t
  string_value = string_function()
  t = box.tuple.new({1,string_value})
  box.space.tester:replace(t)
end function string_function()
  local random_number
  local random_string
  random_number = math.random(65, 90)
  random_string = string.char(random_number)
  return random_string
end function string_function()
  local random_number
  local random_string
  random_string = ""
  for x = 1,10,1 do
    random_number = math.random(65, 90)
    random_string = random_string .. string.char(random_number)
  end
  return random_string
end function string_function()
           local random_number
           local random_string
           random_string = ""
           for x = 1,10,1 do
             random_number = math.random(65, 90)
             random_string = random_string .. string.char(random_number)
           end
           return random_string
         end
         
         function main_function()
           local string_value, t
           for i = 1,1000000,1 do
             string_value = string_function()
             t = box.tuple.new({i,string_value})
             box.space.tester:replace(t)
           end
         end
         start_time = os.clock()
         main_function()
         end_time = os.clock()
         'insert done in ' .. end_time - start_time .. ' seconds' function string_function()
  return "hello world"
end json = require('json')
function sum_json_field(field_name)
  local v, t, sum, field_value, is_valid_json, lua_table
  sum = 0
  for v, t in box.space.tester:pairs() do
    is_valid_json, lua_table = pcall(json.decode, t[2])
    if is_valid_json then
      field_value = lua_table[field_name]
      if type(field_value) == "number" then sum = sum + field_value end
    end
  end
  return sum
end main_function()
         box.space.tester:select{1} что означает, что первое поле кортежа, первичное поле, представляет собой число, а второе поле кортежа, JSON-строка, является строкой. Таким образом, значение оператора будет следующим: "декодировать ``t[2]`` (второе поле кортежа) как JSON-строку; если обнаружится ошибка, то указать ``is_valid_json = false``; если ошибок нет, указать ``is_valid_json = true`` и ``lua_table =`` Lua-таблица, в которой находится декодированная строка". string_function() tarantool> function main_function()
         >   local string_value
         >   string_value = string_function()
         >   return string_value
         > end
---
...
tarantool> main_function()
---
- hello world
...
tarantool> tarantool> function main_function()
         >   local string_value, t
         >   string_value = string_function()
         >   t = box.tuple.new({1,string_value})
         >   box.space.tester:replace(t)
         > end
---
...
tarantool> main_function()
---
...
tarantool> box.space.tester:select{1}
---
- - [1, 'EUJYVEECIL']
...
tarantool> tarantool> function main_function()
         > local string_value, t
         > string_value = string_function()
         > t = box.tuple.new({1, string_value})
         > return t
         > end
---
...
tarantool> main_function()
---
- [1, 'PNPZPCOOKA']
...
tarantool> tarantool> function string_function()
         >   local random_number
         >   local random_string
         >   random_number = math.random(65, 90)
         >   random_string = string.char(random_number)
         >   return random_string
         > end
---
...
tarantool> main_function()
---
- C
...
tarantool> tarantool> function string_function()
         >   local random_number
         >   local random_string
         >   random_string = ""
         >   for x = 1,10,1 do
         >     random_number = math.random(65, 90)
         >     random_string = random_string .. string.char(random_number)
         >   end
         >   return random_string
         > end
---
...
tarantool> function main_function()
         >   local string_value, t
         >   for i = 1,1000000,1 do
         >     string_value = string_function()
         >     t = box.tuple.new({i,string_value})
         >     box.space.tester:replace(t)
         >   end
         > end
---
...
tarantool> start_time = os.clock()
---
...
tarantool> main_function()
---
...
tarantool> end_time = os.clock()
---
...
tarantool> 'insert done in ' .. end_time - start_time .. ' seconds'
---
- insert done in 37.62 seconds
...
tarantool> tarantool> function string_function()
         >   local random_number
         >   local random_string
         >   random_string = ""
         >   for x = 1,10,1 do
         >     random_number = math.random(65, 90)
         >     random_string = random_string .. string.char(random_number)
         >   end
         >   return random_string
         > end
---
...
tarantool> main_function()
---
- 'ZUDJBHKEFM'
...
tarantool> tarantool> function string_function()
         >   return "hello world"
         > end
---
...
tarantool> string_function()
---
- hello world
...
tarantool> tarantool> indexed_pattern_search("t", 2, "ABC.E.")
---
- - [7, 'ABCDEF', 'a']
... tarantool> sum_json_field("Quantity")
---
- 22
... затем добавим несколько кортежей, где первое поле является числовым, а второе поле представляет собой строку. 