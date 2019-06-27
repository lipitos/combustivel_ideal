class Posto{
  int id;
  String nome;
  String alcool;
  String gasolina;
  String data;

  Posto();

  Posto.fromMap(Map map){
    id = map["c_id"];
    nome = map["c_nome"];
    alcool = map["c_alcool"];
    gasolina = map["c_gasolina"];
    data = map["c_data"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "c_nome": nome,
      "c_alcool": alcool,
      "c_gasolina": gasolina,
      "c_data": data,
    };
    if(id != null){
      map["c_id"] = id;
    }
    return map;
  }

  @override
  String toString(){
    return "Posto[ id: $id, "
        "nome: $nome, "
        "alcool: $alcool, "
        "gasolina: $gasolina"
        "data: $data"
        "]";
  }
}