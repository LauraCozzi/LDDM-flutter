import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class _Task {
  int idTask;
  String taskText;

  _Task(idTarefa, tarefa) {
    this.idTask = idTarefa;
    this.taskText = tarefa;
  }
}

class PaginaLista extends StatefulWidget {
  @override
  _PaginaListaState createState() => _PaginaListaState();
}

class _PaginaListaState extends State<PaginaLista> {
  List<_Task> _listTasks = [];
  TextEditingController _controllerTask = TextEditingController();

  @override
  void initState() {
    _listarTarefas().then((List<_Task> list) {
      setState(() {
        _listTasks = list;
      });
    });

    super.initState();
  }

  _deleteTask(int id) async {
    Database bd = await _readData();
    int retorno = await bd.delete("tarefas", where: "id=?", whereArgs: [id]);
  }

  _updateTask(int id) async {
    Database bd = await _readData();
    Map<String, dynamic> dadosTarefa = {
      "tarefa": _controllerTask.text,
    };
    int retorno = await bd
        .update("tarefas", dadosTarefa, where: "id=?", whereArgs: [id]);
  }

  _saveData(String tarefa) async {
    Database bd = await _readData();
    Map<String, dynamic> dadosTarefa = {
      "tarefa": tarefa,
    };
    int id = await bd.insert("tarefas", dadosTarefa);
    setState(() {
      _listTasks.add(_Task(id, _controllerTask.text));
    });
  }

  _readData() async {
    final pathBancoDados = await getDatabasesPath();
    final localBancoDados = path.join(pathBancoDados, "banco.bd");
    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String sql =
          "CREATE TABLE tarefas (id INTEGER PRIMARY KEY AUTOINCREMENT, tarefa VARCHAR) ";
      db.execute(sql);
    });
    return bd;
  }

  Future<List<_Task>> _listarTarefas() async {
    Database db = await _readData();
    List<Map<String, dynamic>> tarefas =
        await db.rawQuery("SELECT * FROM tarefas");
    List<_Task> resp = [];
    for (Map<String, dynamic> tasks in tarefas) {
      resp.add(_Task(tasks["id"], tasks["tarefa"]));
    }
    return resp;
  }

  _resetFields() {
    _controllerTask.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Lista de Tarefas',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        elevation: 6,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Adicionar Tarefa: "),
                  content: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(labelText: "Digite sua tarefa"),
                    controller: _controllerTask,
                  ),
                  actions: <Widget>[
                    FlatButton(
                        textColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar")),
                    FlatButton(
                        textColor: Colors.blueAccent,
                        onPressed: () async {
                          _saveData(_controllerTask.text);
                          Navigator.pop(context);
                        },
                        child: Text("Salvar")),
                    _resetFields(),
                  ],
                );
              });
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _listTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _listTasks[index].taskText,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueAccent,
                    ),
                  ),
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Atualizar tarefa"),
                            content: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  labelText: "Digite sua tarefa"),
                              controller: _controllerTask,
                              validator: (String text) {
                                if (text.isEmpty) {
                                  return "Digite a tarefa";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  textColor: Colors.blueAccent,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancelar")),
                              FlatButton(
                                  textColor: Colors.black,
                                  onPressed: () async {
                                    _updateTask(
                                        _listTasks[index].idTask);
                                    setState(() {
                                      _listTasks[index].taskText =
                                          _controllerTask.text;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("Salvar")),
                              _resetFields(),
                            ],
                          );
                        });
                  },
                  onLongPress: () async {
                    _deleteTask(_listTasks[index].idTask);
                    setState(() {
                      _listTasks.remove(_listTasks[index]);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
