# README

#### Tool version
0.0.2

#### Description
Скрипт для приведения к каноническому удобочитаемому виду cwl-схем тулов и воркфлоу в формате YAML. Скрипт производит следующие действия:

	1. Удаляет из схемы лишние поля:
	
		*  сгенеренные рабиксом:   'sbg:x', 'sbg:y', 'sbg:job' +++
		*  с дефолтными значениями: 'separate': true 
		*  c пустыми значениями
		*  поля label, если их значения совпадают с id текущего элемента
		
	2. Сортирует ключи верхнего уровня в соответствии с заданным порядком:
	
		* для тулов: 'cwlVersion', 'class', 'id', 'label', 'doc', 'baseCommand', 'arguments', 'inputs', 'outputs', 'requirements'
		* для воркфлоу: 'cwlVersion', 'class', 'id', 'label', 'doc', 'inputs', 'outputs', 'steps',  'requirements' +++
	 
	3. Сортирует элементы тула:
	
		* tool arguments - сортировка по position; если position не задан, то считать его за 0; аргументы с одинаковым position - по prefix
		* tool inputs - сортировка по position; если position не задан, то считать его за 0; инпуты с одинаковым position - по id; без inputBinding - в конце по алфавиту
		* tool outputs - сортировка по id
		* элементы верхнего уровня для каждого tool input - в порядке 'id', 'label', 'doc', 'type', 'inputBinding', 'default', 'format'
		
	4. Сортирует элементы воркфлоу:
	
		* workflow inputs и outputs - сортировка по id +++
		* элементы верхнего уровня для каждого wf input - в порядке 'id', 'label', 'doc', 'type', 'inputBinding', 'default', 'format' +++
		* схема тула внутри wf run изменяется по правилам тула (если она прописана явно, а не ссылкой)

	5. Сортирует элементы степа воркфлоу:
	
		* элементы workflow step - в порядке 'id', 'label', 'in', 'out', 'run'
		* элементы workflow step in - в порядке 'id', 'source', 'default'

	6. Везде, где способ сортировки не прописан явно, производится лексикографическая сортировка.


#### Input
* CWL-схема тула или воркфлоу в формате YAML

#### Output
* измененная CWL-схема тула или воркфлоу в формате YAML


#### Examples

Можно запускать любым из способов:
```bash
./beautify.py /path/to/cwl_schema.yml /path/to/cwl_schema_beautified.yml

python beautify.py /path/to/cwl_schema.yml /path/to/cwl_schema_beautified.yml

python3 beautify.py /path/to/cwl_schema.yml /path/to/cwl_schema_beautified.yml
```

Для того, чтобы все изменения сохранились в исходном файле (без создания нового), необходимо вторым аргументом передать имя исходного файла:
```bash
./beautify.py /path/to/cwl_schema.yml /path/to/cwl_schema.yml
```

#### Warning! 
В текущей версии v0.0.2 скрипт работает частично:)


#### Help & usage
TODO


#### TODO
 * Расширить функционал
 * Add JSON support.
 * В inputBinding если нет prefix, то separate в любом случае нужно удалять, т.к. все равно игнорируется.
 * Добавить опцию при запуске, которая будет типа "--inplace". Если она задана, то изменения призводятся прямо в том файле, который подан на вход.


#### Repo owner
[Konstantin Grammatikati](mailto:grammatikati@cspmz.ru)

#### Contributors
[Konstantin Grammatikati](mailto:grammatikati@cspmz.ru)
