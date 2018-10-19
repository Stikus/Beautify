import yaml

so_wf = ['cwlVersion', 'class', 'id', 'label', 'doc', 'inputs', 'outputs', 'steps',  'requirements']
so_tool = ['cwlVersion', 'class', 'id', 'label', 'doc', 'baseCommand', 'arguments', 'inputs', 'outputs', 'requirements']
so_wf_input = ['id', 'label', 'doc', 'type', 'inputBinding', 'default', 'format']

with open("example.yaml", 'r') as stream:
    try:
        with open("output.yaml", "w") as f:
            data = yaml.load(stream)
            allkeys = []
            allkeys.extend(data.keys())
            if data['class'] == 'Workflow':
                allkeys_good = [val for val in so_wf if val in allkeys]
                allkeys_bad = sorted(list(set(allkeys) - set(so_wf)))
                for keyw in allkeys_good:
                    if keyw == 'inputs':
                        print('inputs:', file=f)
                        data[keyw] = sorted(data[keyw], key=lambda k: k['id'])
                        for elem in data[keyw]:
                            elemkeys = []
                            elemkeys.extend(elem.keys())
                            elemkeys_good = [val for val in so_wf_input if val in elemkeys]
                            elemkeys_bad = sorted(list(set(elemkeys)-set(so_wf_input)))
                            for keyi in elemkeys_good:
                                if keyi == 'id':
                                    print("  -", keyi, ":", elem[keyi], file=f)
                                else:
                                    print("   ", keyi, ":", elem[keyi], file=f)
                            for keyi in elemkeys_bad:
                                if (keyi != 'sbg:x' and keyi != 'sbg:y' and keyi != 'sbg:job'):
                                    if keyi == 'id':
                                        print("  -", keyi, ":", elem[keyi], file=f)
                                    else:
                                        print("   ", keyi, ":", elem[keyi], file=f)
                    elif keyw == 'outputs':
                        print('outputs:', file=f)
                        data[keyw] = sorted(data[keyw], key=lambda k: k['id'])
                        for elem in data[keyw]:
                            for keyi in elem:
                                if (keyi != 'sbg:x' and keyi != 'sbg:y' and keyi != 'sbg:job'):
                                    if keyi == 'id':
                                        print("  -", keyi, ":", elem[keyi], file=f)
                                    else:
                                        print("   ", keyi, ":", elem[keyi], file=f)
                    elif keyw == 'steps':
                        print('steps')
                    else:
                        print(keyw, ": ", data[keyw], sep = '', file=f)
                for keyw in allkeys_bad:
#                    print('badkeys after', file=f)
                    print(keyw, ": ", data[keyw], sep = '', file=f)
            print(allkeys_bad)
    except yaml.YAMLError as exc:
        print(exc)