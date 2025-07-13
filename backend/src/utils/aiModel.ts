// simulate
export async function SendDataToAIModel(data: ArrayBuffer): Promise<string> {
  // simulate async logic, e.g., AI model call
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve('CA07TRE')
    }, 3000)
  })
}
