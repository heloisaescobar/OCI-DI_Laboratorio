# OCI-DI_Laboratorio

## OCI Data Integration

<i>Pré Requisitos: Ter Compartimento Criado, VCN, Aplicar as [Policies](https://github.com/heloisaescobar/InLab-Pipeline-Dados-Aplicado-Eventos/blob/master/scripts_apoio/policies_anexo.txt)</i>.

### Criação do Workspace

<b>Provisionamento do Workspace</b>

Expanda a lista de serviços da OCI utilizando o menu de hambúrguer, no canto superior esquerdo. Em seguida, selecione Oracle Database e clique em Analytics & AI e clique me Data Integration

![image](https://user-images.githubusercontent.com/46925501/155429984-23074dfd-a568-4474-bd97-fbb84aa25f3f.png)

Clique em <i>Create Workspace</i>

![image](https://user-images.githubusercontent.com/46925501/161565524-9048b915-44b0-489e-90ad-b53b643e4478.png)

Dê um nome ao Workspace, Descrição, clique em ‘Enable private Networking’ e selcione uma VCN e uma Subnet <i>PRIVADA</i>. Em seguida clique em <i>Create</i>.

![image](https://user-images.githubusercontent.com/46925501/161566794-3ef55c8f-874b-4169-9580-dea209d0aa01.png)

Após alguns minutos você verá seu workspace listado como <i>Active</i>.

![image](https://user-images.githubusercontent.com/46925501/161567062-5b837e0e-6dbc-4f7d-9c3e-e65e97ac5d32.png)

### Criação dos Data Assets

<b>Criando o Data Asset do Autonomous Data Warehouse</b>

Pré-requisito: Ter um Autonomous Data Warehouse provisionado, ter um usuário com privilégios DBMS_CLOUD e DWROLE. Para provisionar o Autonomous [clique aqui](https://github.com/heloisaescobar/InLab-Pipeline-Dados-Aplicado-Eventos#autonomous-data-warehouse)

Antes começarmos a criação do Data Asset do Oracle Autonomous Data Warehouse nós precisamos salvar a Wallet de acesso ao banco. Para isso siga os passos abaixo:
Expanda a lista de serviços da OCI utilizando o menu de hambúrguer, no canto superior esquerdo. Em seguida, selecione Oracle Database e clique em Autonomous Data Warehouse.

![image](https://user-images.githubusercontent.com/46925501/155430296-1fc6b6be-c5a3-47e8-9108-c4cb1776f376.png)

Em seguida, clique sobre o nome da instância de Autonomous Data Warehouse que você tenha disponível (pré-requisito)

![image](https://user-images.githubusercontent.com/46925501/161569330-7b917faa-c748-40da-ad99-5243dd606613.png)

Você será redirecionado para uma janela com os detalhes da instância de Autonomous Data Warehouse. Nesta tela clique sobre o botão DB Connection.

![image](https://user-images.githubusercontent.com/46925501/161569598-8ab556b7-87fb-42a4-8803-8638172c36d4.png)

Uma caixa de diálogo será exibida. Nesta, clique em Download Wallet.

![image](https://user-images.githubusercontent.com/46925501/155430342-6432977a-da15-45ec-aecc-a902c17bf714.png)

Digite uma senha de sua preferência, clique em Download e salve o arquivo .zip em uma pasta desejada.

![image](https://user-images.githubusercontent.com/46925501/155430352-6ca40330-33c3-42ee-9a30-4a02befa546f.png)

Acesse a aba do OCI Data Integration:

![image](https://user-images.githubusercontent.com/46925501/155430369-d5144133-97da-4d7b-be95-7cdb96556074.png)

E selecione o Workspace que foi criado durante a parte de preparação do ambiente:

![image](https://user-images.githubusercontent.com/46925501/161567062-5b837e0e-6dbc-4f7d-9c3e-e65e97ac5d32.png)

Clique no sinal de <b>+</b> e em seguida clique em Data Assets

![image](https://user-images.githubusercontent.com/46925501/155430452-cbc4d61f-d6f9-4dd3-96e8-f19c10457026.png)

Clique em Create Data Asset, você pode observar que uma nova aba chamada Create Data Asset foi aberta.

![image](https://user-images.githubusercontent.com/46925501/155430469-201cf816-1e80-4441-a219-72976c0b40eb.png)

Dê o nome ao Data Asset <i>DA_ADW01</i> (como na imagem) e selecione o Type como Oracle Autonomous Data Warehouse.

![image](https://user-images.githubusercontent.com/46925501/155430490-75e71c87-ae4b-4444-9224-6c2f87f27f46.png)

Mais abaixo, na mesma página mantenha o botão de rádio Upload Wallet selecionado., clique em Select File e localize o arquivo .zip que você fez o download anteriormente. Faça a carga do arquivo .zip, insira a senha do .zip e escolha o Service Name <b>(<nome_do_ADW>.medium)</b>

![image](https://user-images.githubusercontent.com/46925501/155430535-0d260919-2398-44e5-832c-75601b5f8655.png)

Deixe a opção Default Connection no Name e Identifier. Em seguida coloque o User name e Password fornecido na criação do banco de dados.
  
Clique em Teste Connection, se a conexão for bem sucedida clique no botão <i>Create</i>.

![image](https://user-images.githubusercontent.com/46925501/155430632-78dc0791-c3e1-4fb5-84f6-34d01e263b0e.png)

Pronto você criou um Data Asset do Oracle Autonomous Data Warehouse.

<b>Criando o Data Asset do Object Storage</b>
  
Retorne para a aba do OCI Data Integration

![image](https://user-images.githubusercontent.com/46925501/155430849-aaadbef9-866c-4234-aa3b-bee93b6c806e.png)

E selecione o Workspace que foi criado durante a parte de preparação do ambiente.
  
![image](https://user-images.githubusercontent.com/46925501/161567062-5b837e0e-6dbc-4f7d-9c3e-e65e97ac5d32.png)

Clique no sinal de <b>+</b> e em seguida clique em Data Assets

![image](https://user-images.githubusercontent.com/46925501/155430906-238282a3-7fea-4829-8ded-626827d63679.png)

Clique em Create Data Asset, você pode observar que uma nova aba chamada Create Data Asset foi aberta.

![image](https://user-images.githubusercontent.com/46925501/155430929-cc3e81d7-0641-459f-88a0-81a69a70bde6.png)

Dê o nome ao Data Asset “DA_OBJstorage” (como na imagem) e selecione o Type como Oracle Object storage

![image](https://user-images.githubusercontent.com/46925501/155430952-90c03e17-a0bb-420d-8760-279dbd0ce87d.png)

Nesta fase, necessitamos de algumas informações que estão distribuídas na console da OCI. Duplique a aba do seu navegador para navegar pelas próximas páginas. Primeiro precisaremos da “tenancy OCID” em seguida o Namespace do Object Storage.

Na aba duplicada, no o canto superior direito clique na figura humana e, em seguida, clique em Tenancy.
  
![image](https://user-images.githubusercontent.com/46925501/161623563-900a6e03-8230-4cc2-8d25-a383893807bf.png)

Uma tela com os detalhes da Tenancy será exibida. Localize o campo OCID e clique em Copy.
  
![image](https://user-images.githubusercontent.com/46925501/161624072-3d7bc5e3-e421-43ba-96cc-6731a8e8194e.png)

Reserve esse ID da tenancy, em seguida copie e reserve o identificador do Namespace do Object Storage.

Retorne à aba do OCI Data Integration em que está criando o data asset do Object Storage e insira os valores copiados no campo Tenant OCID e Namespace. (Geralmente o campo Namespace é preenchido automaticamente após você colocar o OCID da tenancy, mas caso isso não ocorra cole o Namespace que você salvou no passo anterior)
A ultima informação necessário para configurarmos o Data Asset do Object Storage é o identificador da sua Region, você vai encontra-lo em sua URL como representado no imagem abaixo

![image](https://user-images.githubusercontent.com/46925501/155431089-7885a910-d1db-4b0d-a0b9-8139baa736f8.png)
  
Agora preencha as informações conforme a imagem abaixo:

![image](https://user-images.githubusercontent.com/46925501/155431113-1920ab63-c9a8-44d8-9b48-1fbaef95406b.png)

Mantenha as opções de Connection como estão e clique em Test Connection.
Se conexão for bem sucedida clique em Create:
![image](https://user-images.githubusercontent.com/46925501/155431192-ee12bbbf-6093-495a-8bd6-f9ca5c430ad2.png)

Você finalizou a criação dos Data Assets!

### Criação e Configuração do DataFlow Designer

<b>Criação do DataFlow</b>
Acesse a aba do OCI Data Integration

![image](https://user-images.githubusercontent.com/46925501/155432024-efe8aa55-967f-4201-99f9-fd123e481a8f.png)

E selecione o Workspace que criamos nos passos anteriores

![image](https://user-images.githubusercontent.com/46925501/155432080-749e96f2-2ac0-4229-8773-b247b7deb1d5.png)

Clique no sinal de <b>+</b> e em seguida clique em Projects

![image](https://user-images.githubusercontent.com/46925501/155432105-6fd3dfde-3242-4eb4-9a22-18b90b7464c2.png)

Selecione o projeto existente no Workspace - My First Project

![image](https://user-images.githubusercontent.com/46925501/155432118-5315eab4-6d67-4c92-98a8-1c614e56cf7d.png)

Selecione a guia Data Flow na lateral esquerda e em seguida clique em Create Data Flow.

![image](https://user-images.githubusercontent.com/46925501/155432135-e03b52a2-0cbd-4751-b424-b02d1a2037c1.png)

<b>Configurando o Data Flow</b>

Com os canvas do data flow aberto vamos fazer o desenho do fluxo de dados e configurar cada um dos operadores.
Na tela do Data Flow desing, no painel de Properties, dê um nome ao Data Flow e verifique se o projeto correto está selecionado.

![image](https://user-images.githubusercontent.com/46925501/155432175-eda23ed5-3ded-49cc-94b7-ee7b7493979d.png)

DICA: para facilitar a visualização você pode clicar nas setas na lateral superior direita para expandir e diminuir o tamanho do Painel properties:
![image](https://user-images.githubusercontent.com/46925501/155432193-c375620d-0d5c-4080-a599-a2da8fa3fb65.png)

<b>Configurando os Operadores</b>

Em seguida vamos começar a criação do Fluxo de Dados
Clique no Painel Operators e arraste um Operador de Source (Fonte) e um de Target (Destino)
![image](https://user-images.githubusercontent.com/46925501/155432273-a19c65ff-6ba7-4388-bf17-e0ca8ed926dd.png)

Clique no Operador Source que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties dê um nome ao Operator (SOURCE_PERSONAGENS)
  
![image](https://user-images.githubusercontent.com/46925501/155432385-f5280bcc-db45-4706-bdbf-b00c60df4f7a.png)

Agora nós vamos configurar cada propriedade indicada no Painel Properties: Data Asset, Connection, Schema e Data Entity, conforme abaixo:

![image](https://user-images.githubusercontent.com/46925501/155432475-ac240cbb-9439-4b18-9267-39df0845f550.png)

<b>Agora arraste coloque outro Operador Source no Canvas, ele será configurado para ser a Source do arquivo que vem do function, conforme abaixo:</b>
![image](https://user-images.githubusercontent.com/46925501/155432585-a1c7eaac-e8f9-4758-96cd-b54f6641f99b.png)

### Configurando o Operador Target

Clique no Operador Target que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties dê um nome ao Operator ‘TARGET_ADW’. Em Integration Strategy selecione a opção Insert:

![image](https://user-images.githubusercontent.com/46925501/155432705-599b4d60-cf35-4193-ba01-ee1b3c7d628b.png)

Agora nós vamos configurar cada propriedade indicada no Painel Properties: Data Asset, Connection, Schema, Data Entity e Staging Location. O processo é muito semelhante a configuração do Source Operator.
* Vamos Utilizar o Schema ADMIN para fins didáticos, o ideal é que você tenha outro usuário disponível no seu ADW (Autonomous Data Warehouse) que você possa usar. 
Faça a configuração com base no nome que você a cada item demonstrado. Lembre-se de dar um nome ao seu Operador Target e marcar a opção Create New Data Entity

![image](https://user-images.githubusercontent.com/46925501/155432770-fdb7ac7b-2634-4fc9-8375-3fa7267693d8.png)

Agora vamos selecionar a Staging Location. Clique em Select em frente a Staging Location e preencha as informações conforme a imagem abaixo:
  
![image](https://user-images.githubusercontent.com/46925501/155432804-1cbbf851-526b-4f49-8a66-4002ade74301.png)

### Configurando os Shaping Operators

Coloque no canvas um Operator Join e um Operator Filter
Após arrastar os Operadores conecte cada um dele conforme a Imagem Abaixo: 
  
![image](https://user-images.githubusercontent.com/46925501/155432915-ee017a01-7571-4682-90d6-0c1737ea78c3.png)

-> Para conectar os Operadores basta descansar o mouse sobre o operador até que uma bolinha apareça no lado direito do operador, após isso basta clicar na bolinha e arrastas a linha até o operador que você deseja fazer a conexão:
  
![image](https://user-images.githubusercontent.com/46925501/155432937-743f2d1d-3dc9-41bb-a9fc-02c2a740e641.png)

<b>Configurando o Operador Join</b>
Clique no Operador Join que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties dê um nome ao Operator:
  
![image](https://user-images.githubusercontent.com/46925501/155433055-1e53e9d5-da6c-4a36-9127-0b96d8f7ca38.png)

Em seguinda, vamos selecionar o Join Type e criar uma condição, conforme abaixo:
  
![image](https://user-images.githubusercontent.com/46925501/155433126-0a75493c-6f57-4478-9693-5e0da673b903.png)

<b>Configurando o Operador Filter</b>

Clique no Operador Filter que você arrastou até o Canvas do Data Flow, em seguida no Painel Properties dê um nome ao Operator. Clique em Filter Condition e informe a condição conforme abaixo:

![image](https://user-images.githubusercontent.com/46925501/155433256-624b5a68-be3f-4598-aab7-482501481635.png)

Pronto! Todos os Operadores do Data Flow Designer estão configurados
Agora Clique em Save and Close 

### Criação e Execução da Integration Tasks
  
Nessa seção vamos criar e configurar uma Integration Task
Clique no sinal de + e selecione Application

![image](https://user-images.githubusercontent.com/46925501/155433320-daee7bca-13ed-4123-9d28-fb29204768a8.png)

Acesse a Default Application que estará disponível no seu Workspace
  
![image](https://user-images.githubusercontent.com/46925501/155433335-a089780f-e8f7-4cfc-bbf5-ced95b42d85a.png)

Toda Integration Task deverá ser publicada aqui nessa Application. Agora continue para a próxima sessão “Criando Integration Task”
  
<b>Criando Integration Task</b>

Clique no sinal de + e em seguida clique em Projects
  
![image](https://user-images.githubusercontent.com/46925501/155433383-babeeae7-4300-4a9f-a2bc-32c1b1c0d8c0.png)

Selecione o projeto existente no Workspace - My First Project

![image](https://user-images.githubusercontent.com/46925501/155433402-facda9a3-8063-43c0-a5b7-e600da9350e8.png)

Em seguida clique em Task na parte esquerda da tela. Clique em Create Task e escolha a Opção Integration

![image](https://user-images.githubusercontent.com/46925501/155433415-8ee61caf-c603-4498-8ef2-a344d3eb341c.png)

Dê um nome a Integration Task e verifique se o seu Projeto está selecionado, em seguida clique no botão Select para selecionar o Data Flow que será usado na Task

![image](https://user-images.githubusercontent.com/46925501/155433433-a9ba9716-fe13-4208-8f53-dac5abfac994.png)

Selecione o Data Flow que criamos na seção anterior e clique em Select
  
![image](https://user-images.githubusercontent.com/46925501/155433451-7cb0534a-3055-49c6-a98e-b251a634365c.png)

Aguarde a Validação e clique em Create and Close

![image](https://user-images.githubusercontent.com/46925501/155433469-ea17c92f-70c6-4163-a1db-9662c5c41638.png)

<b>Executando a Task Integration</b>
Clique no sinal de + e em seguida clique em Projects
  
![image](https://user-images.githubusercontent.com/46925501/155433493-74268f04-0aa1-4829-bca4-fa75ba617fc2.png)

Selecione o projeto existente no Workspace - My First Project
 
![image](https://user-images.githubusercontent.com/46925501/155433506-11bcd9bd-3bc8-49aa-a101-b6064e610bd2.png)

Clique na aba Tasks e localize a Integration Task que criamos na seção anterior. Clique no menu de ação no lado direito da integration task (representado por 3 pontinhos como indicado na imagem)

![image](https://user-images.githubusercontent.com/46925501/155433528-b7767650-8b6e-4c28-ab97-19cd45398410.png)

Clique em Publish to Application

![image](https://user-images.githubusercontent.com/46925501/155433538-2e727621-e96b-46f5-b351-4ef36cfffc91.png)

Selecione a Default Application e clique em Publish
  
![image](https://user-images.githubusercontent.com/46925501/155433550-bcb2e853-51b8-4b88-967e-54417295832e.png)

Agora clique no sinal de + e selecione Application
  
![image](https://user-images.githubusercontent.com/46925501/155433565-93a62506-9e10-45d5-b037-96ff9927f5f5.png)

Acesse a Default Application que estará disponível no seu Workspace
  
![image](https://user-images.githubusercontent.com/46925501/155433586-ab7ae1ce-ad9a-4817-9ff6-3f8b2668e302.png)

Ao acessar a Application você vai localizar a Integration Task que publicamos na seção anterior 
 
![image](https://user-images.githubusercontent.com/46925501/155433610-2ed87d93-435b-4492-aa7b-10b57c029314.png)

Clique no menu de ação no lado direito da integration task (representado por 3 pontinhos como indicado na imagem) e selecione a opção Run

![image](https://user-images.githubusercontent.com/46925501/155433625-bfd45547-35e3-4896-8391-83178df3d00e.png)
  
A execução da integration task vai começar e você será direcionado para a aba Runs (ainda dentro de Applications)
Você pode utilizar o botão Refresh para visualizar o progresso da integration task

![image](https://user-images.githubusercontent.com/46925501/155433642-e82cf5b1-b8e2-4cf5-abcf-a9a158244de9.png)

Após o Status aparecer como ‘Sucess’ a integration task estará concluída com sucesso! 
Os arquivos .CSV que estavam no Oracle Object Storage foram extraídos, transformados (Data Flow designer) e carregados no Oracle Autonomous Data Warehouse.
