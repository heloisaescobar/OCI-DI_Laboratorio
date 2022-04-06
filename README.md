# Laboratório - Criação Pipeline de Dados (OCI Data Integration e OCI Data Flow)

## Roteiro
* [Provisionamento Workspace - OCI Data Integration]
* [Provisionamento Data Flow]
* [Preparação Procedure - Autonomous]
* [Montagem Pipeline]

## OCI Data Integration

<i>Pré Requisitos: Ter Compartimento Criado, VCN, Aplicar as [Policies](https://github.com/heloisaescobar/InLab-Pipeline-Dados-Aplicado-Eventos/blob/master/scripts_apoio/policies_anexo.txt)</i>.

### Provisionamento Workspace

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

![image](https://user-images.githubusercontent.com/46925501/161624619-7d3e88e2-9efc-49b5-91a0-60376dc1fb80.png)

Mantenha as opções de Connection como estão e clique em Test Connection.
Se conexão for bem sucedida clique em Create:
![image](https://user-images.githubusercontent.com/46925501/155431192-ee12bbbf-6093-495a-8bd6-f9ca5c430ad2.png)

Você finalizou a criação dos Data Assets!

