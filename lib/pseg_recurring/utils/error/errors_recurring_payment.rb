module Psegrecurring
  class Error
    class RecurringPayment

      def initialize(code)
        @code = code
      end

      def parse
        return errors.fetch(@code.to_sym)
      end

      private
      def errors
        @errors ||= {
          :'10003' => "Email inválido.",
          :'10005' => "A conta do vendedor e do comprador não podem estar relacionadas",
          :'10009' => "Método de pagamento está atualmente indisponível",
          :'10020' => "Método de pagamento inválido",
          :'10021' => "Erro ao baixar dados do vendedor do sistema",
          :'10023' => "Método de pagamento indisponível",
          :'10024' => "O comprador deve estar cadastrado",
          :'10025' => "senderName não pode ser vazio",
          :'10026' => "senderEmail não pode ser vazio",
          :'10049' => "senderName é obrigatório",
          :'10050' => "senderEmail é obrigatório",
          :'11002' => "receiverEmail tamanho inválido",
          :'11006' => "redirectURL tamanho inválido",
          :'11007' => "redirectURL valor inválido",
          :'11008' => "reference tamanho inválido",
          :'11013' => "senderAreaCode valor inválido",
          :'11014' => "senderPhone valor inválido",
          :'11027' => "Quantidade de itens fora do intervalo",
          :'11028' => "Valor total do item é obrigatório. (ex: 12.00)",
          :'11040' => "maxAge formato inválido. Deve ser um inteiro",
          :'11041' => "maxAge fora do intervalo",
          :'11042' => "maxUses formato inválido. Deve ser um inteiro",
          :'11043' => "maxUses fora do intervalo",
          :'11054' => "abandonURL/reviewURL tamanho inválido",
          :'11055' => "abandonURL/reviewURL valor inválido",
          :'11071' => "preApprovalInitialDate valor inválido",
          :'11072' => "preApprovalFinalDate valor inválido",
          :'11084' => "O vendedor não tem opção de pagamento com cartão de crédito",
          :'11101' => "Dados da assinatura são obrigatórios",
          :'11163' => "Você deve configurar uma URL de notificações de transações antes de usar este serviço",
          :'11211' => "Assinatura não pode ser paga duas vezes no mesmo dia",
          :'13001' => "Código da notificação inválido",
          :'13005' => "initialDate deve ser inferior ao limite permitido.",
          :'13006' => "initialDate não deve ter mais de 180 dias",
          :'13007' => "initialDate deve ser menor ou igual ao finalDate.",
          :'13008' => "O intervalo de busca deve ser menor ou igual a 30 dias",
          :'13009' => "finalDate deve ser inferior ao limite permitido.",
          :'13010' => "initialDate formato inválido. Use yyyy-MM-ddTHH:mm (ex: 2010-01-27T17:25).",
          :'13011' => "finalDate formato inválido. Use yyyy-MM-ddTHH:mm (ex: 2010-01-27T17:25). ",
          :'13013' => "Valor da página é inválido.",
          :'13014' => "maxPageResults valor inválido (must be between 1 and 1000).",
          :'13017' => "initialDate e finalDate são obrigatórios na pesquisa por intervalo de datas",
          :'13018' => "O intervalo deve está entre 1 e 30",
          :'13019' => "Notificação do intervalo é obrigatória",
          :'13020' => "A página informada é maior que o total de páginas retornado",
          :'13023' => "Invalid minimum reference length (1-255)",
          :'13024' => "Invalid maximum reference length (1-255)",
          :'17008' => "Assinatura não encontrada",
          :'17022' => "Status da assinatura é inválido para executar essa operação",
          :'17023' => "O vendedor não tem opção de pagamento com cartão de crédito",
          :'17024' => "Assinatura não é permitida para este vendedor",
          :'17032' => "Receptor inválido para pagamento verificar o status da conta do destinatário e se é uma conta do vendedor.",
          :'17033' => "preApproval.paymentMethod não é válido. Ele deve ser o mesmo da assinatura",
          :'17035' => "Due days format is invalid.",
          :'17036' => "Due days value is invalid. Any value from 1 to 120 is allowed.",
          :'17037' => "Due days must be smaller than expiration days.",
          :'17038' => "Expiration days format is invalid.",
          :'17039' => "Expiration value is invalid. Any value from 1 to 120 is allowed.",
          :'17061' => "Plano não encontrado",
          :'17063' => "Hash é obrigatório",
          :'17065' => "Documentos são obrigatórios",
          :'17066' => "Quantidade de documentos inválida",
          :'17067' => "O tipo do método de pagamento é obrigatório",
          :'17068' => "O tipo do método de pagamento é inválido",
          :'17069' => "Telefone é obrigatório",
          :'17070' => "Endereço é obrigatório",
          :'17071' => "Sender é obrigatório",
          :'17072' => "Método de pagamento é obrigatório",
          :'17073' => "Cartão de crédito é obrigatório",
          :'17074' => "Titular do cartão de crédito é obrigatório",
          :'17075' => "Token do cartão de crédito é inválido",
          :'17078' => "Cartão expirado",
          :'17079' => "Limite de uso excedido",
          :'17080' => "Assinatura está suspensa",
          :'17081' => "Ordem de pagamento da assinatura não encontrada",
          :'17082' => "Status de pedido de pagamento da assinatura é inválido para executar a operação solicitada",
          :'17083' => "Assinatura já está com esse status",
          :'17093' => "O hash ou IP do remetente é obrigatório",
          :'17094' => "Não pode haver novas assinaturas para um plano inativo",
          :'19001' => "CEP inválido",
          :'19002' => "Rua tem tamanho inválido",
          :'19003' => "Número tem tamanho inválido",
          :'19004' => "Complemento tem tamanho inválido",
          :'19005' => "Bairro tem tamanho inválido",
          :'19006' => "Cidade tem tamanho inválido",
          :'19007' => "Estado tem valor inválido. (ex: SP)",
          :'19008' => "País tem tamanho inválido. (ex: BRA)",
          :'19014' => "Telefone tem valor inválido",
          :'19015' => "País tem valor inválido. (ex: BRA)",
          :'50103' => "CEP não pode ser vazio",
          :'50105' => "Número não pode ser vazio",
          :'50106' => "Bairro não pode ser vazio",
          :'50107' => "País não pode ser vazio",
          :'50108' => "Cidade não pode ser vazio",
          :'50131' => "O endereço de IP não segue um padrão válido",
          :'50134' => "Rua não pode ser vazio",
          :'53037' => "Token do cartão de crédito é obrigatório",
          :'53042' => "Nome do titular do cartão é obrigatório",
          :'53047' => "Data de aniversário do titular do cartão é obrigatório",
          :'53048' => "Data de aniversário de titular do cartão é inválido",
          :'53151' => "Valor do desconto não pode ser vazio",
          :'53152' => "Valor do desconto está fora do permitido. Para DISCOUNT_PERCENT o valor de ser maior ou igual a 0.00, menor ou igual a 100.00.",
          :'53153' => "Próximo pagamento não encontrado para essa assinatura",
          :'53154' => "Status não pode ser vazio",
          :'53155' => "Tipo de desconto é obrigatório",
          :'53156' => "Tipo de desconto tem valor inválido. Tente: DISCOUNT_AMOUNT ou DISCOUNT_PERCENT",
          :'53157' => "Valor do desconto está fora do permitido. Para DISCOUNT_AMOUNT o valor deve ser maior ou igual a 0.00, menor ou igual ao valor máximo do pagamento",
          :'53158' => "Valor do desconto é obrigatório",
          :'57038' => "Estado é obrigatório",
          :'60800' => "Domínio do email do comprador inválido. Você deve usar um email @sandbox.pagseguro.com.br",
          :'61007' => "Tipo de documento é obrigatório",
          :'61008' => "Tipo de documento é inválido",
          :'61009' => "Valor do documento é obrigatório",
          :'61010' => "Valor do documento é inválido",
          :'61011' => "CPF é inválido",
          :'61012' => "CNPJ é inválido"
        }
      end

    end
  end
end