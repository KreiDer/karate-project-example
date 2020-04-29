package org.folio;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.fge.jackson.JsonLoader;
import com.github.fge.jsonschema.core.exceptions.ProcessingException;
import com.github.fge.jsonschema.core.report.ProcessingMessage;
import com.github.fge.jsonschema.core.report.ProcessingReport;
import com.github.fge.jsonschema.main.JsonSchema;
import com.github.fge.jsonschema.main.JsonSchemaFactory;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SchemaValidator {
  private static final Logger logger = LoggerFactory.getLogger(SchemaValidator.class);

  private static Map<String, String> pathMap = new HashMap<>();

  static {
    pathMap.put("fiscal_year", "schema/acq-models/mod-finance/schemas/fiscal_year.json");
    pathMap.put("transaction", "schema/acq-models/mod-finance/schemas/transaction.json");
  }

  public static boolean isValid(String json, String schema) throws Exception {
    if (schema == null || json == null) {
      return false;
    }

    URL schemaFile = SchemaValidator.class.getResource(pathMap.get(schema));
    return isJsonValid(schemaFile, json);
  }

  public static boolean isJsonValid(JsonSchema jsonSchemaNode, JsonNode jsonNode) throws ProcessingException {
    ProcessingReport report = jsonSchemaNode.validate(jsonNode);
    if (!report.isSuccess()) {
      for (ProcessingMessage processingMessage : report) {
        logger.error(processingMessage.getMessage());
      }
    }
    return report.isSuccess();
  }


  public static boolean isJsonValid(URL schemaText, String json) throws ProcessingException, IOException {
    final JsonSchemaFactory factory = JsonSchemaFactory.byDefault();
    final JsonSchema schema = factory.getJsonSchema(schemaText.toString());
    final JsonNode jsonNode = getJsonNode(json);
    return isJsonValid(schema, jsonNode);
  }

  public static JsonNode getJsonNode(String jsonText) throws IOException {
    return JsonLoader.fromString(jsonText);
  }
}
