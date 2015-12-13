### Ruby gem - TranslatorAPI

Library Ruby the translator based on Yandex API.

You need to get a [key](https://tech.yandex.ru/key/form.xml?service=trnsl) to use translator

### Usage
You create an instance of the class Translator::Text to be transferred to the method #new key and language of the translation.
The default language of translation Russian.

You can use ready-made gem installing them with [rubygems](https://rubygems.org)

```ruby
gem install TranslatorAPI
```

After require you can use gem

```ruby
require 'translator_api'
```

```ruby
translator = TranslatorAPI::Translator.new("your key","en") 
```
If your key or reduction of language is wrong it will return nil.

```ruby
Translator::Translator.new("invalid key","en") # => nil
```

## Method #get_list

Call the method #get_list  for determining the list of supported languages and translation directions.

```ruby
langs, dirs = translator.get_list

langs, dirs = Translator.get_list_language 
langs.each { |key, lang| puts "#{key} : #{lang}" } # => af : Африкаанс 
                                                   # => ar : Арабский
                                                   # [list of reduction and language](https://tech.yandex.ru/translate/doc/dg/concepts/langs-docpage/) 

dirs.each { |directions| puts directions} # => az-ru
                                          # => be-bg
                                          # => ... list of translation directions
```

## Method #detect

Call the method #detect for the determination of language of a text.

```ruby
translator.detect "Something text" # => English
```
Returns the value of a language depends on the reduction in the the transmitted method #new.

```ruby
TranslatorAPI::Translator.new("your key","zh").detect "Something text" # => 英語 ("zh" - Chinese)
```

If the language is not supported it will return nil.

```ruby
translator.detect "language is not supported" # => nil
```

## Method #translate

Call the method #translate to translate text. The final language of the translation is determined by the reduction method #new.
Text can not contain more than 10,000 characters else it will return nil.

```ruby
translator.translate "一些文本" # => "Some of the text"
```

If the language is not supported it will return the original text.

```ruby
translator.translate "भाषा" # => "भाषा"
```

You can manually set the translation direction.
Language is supported or not is supported and direction is wrong but exist it will return the original text.

```ruby
translator.translate("text","zh-af") # => "text"
```

Language is supported or not is supported and direction is not exist it will return nil.

```ruby
translator.translate("text","direction is not exist") # => nil
```

## Good luck in the use the Translator

