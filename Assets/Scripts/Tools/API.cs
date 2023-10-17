//using System.Text;
//using UnityEngine;
//using UnityEngine.Networking;
//using System.Threading.Tasks;
//using System.Runtime.CompilerServices;
//using System;
//using System.Collections;

//[ExecuteInEditMode]
//public class API : MonoBehaviour
//{
//	private const string API_URL = "https://api.openai.com/v1/chat/completions"; // Replace with the appropriate endpoint if it's changed
//	private const string API_KEY = "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";
//	public bool send = false;
//	private static bool isGenerating = false;
//	private static string lastResponse;

//	private void Update()
//	{
//		if (send)
//		{
//			send = false;
//			SendMessage();
//		}
//		Debug.Log("Generating: " + isGenerating);
//	}

//	private async void SendMessage()
//	{
//		string prompt = "Translate the following English text to French: 'Hello, how are you?'";
//		var (response, progress) = await GetCompletionFromOpenAI(prompt);
//		StartCoroutine(Respond(progress, prompt, response));
//		//Debug.Log($"Progress: {progress * 100f}%");
//		//Debug.Log(response);
//	}

//	// Divide progress by request count for total progress among multiple requests.
//	IEnumerator Respond(float progress, string prompt, string response)
//	{
//		if (progress < 100)
//		{
//			Debug.Log($"\"{prompt}\" progress: {progress}");
//			yield return null; // Check 5 times in a second
//		}
//		else
//		{
//			Debug.Log("Response: " + lastResponse);
//			yield break;
//		}
//	}

//	public static async Task<(string response, float progress)> GetCompletionFromOpenAI(string prompt)
//	{
//		UnityWebRequest request = new UnityWebRequest(API_URL, "POST");
//		byte[] bodyRaw = Encoding.UTF8.GetBytes($"{{\"model\":\"gpt-4\",\"messages\":[{{\"role\":\"user\",\"content\":\"{prompt}\"}}]}}");
//		request.uploadHandler = new UploadHandlerRaw(bodyRaw);
//		request.downloadHandler = new DownloadHandlerBuffer();
//		request.SetRequestHeader("Authorization", $"Bearer {API_KEY}");
//		request.SetRequestHeader("Content-Type", "application/json");

//		float progress = 0f;
//		isGenerating = true;
//		await request.SendWebRequest().Until(() =>
//		{
//			progress = request.downloadProgress;
//			return false; // Return false to keep the Until loop running until SendWebRequest completes.
//		});

//		if (request.result != UnityWebRequest.Result.Success)
//		{
//			Debug.LogError($"Request failed: {request.error}");
//			Debug.LogError($"Detailed error: {request.downloadHandler.text}");
//			return (null, progress);
//		}
//		isGenerating = false;
//		string jsonResponse = request.downloadHandler.text;
//		lastResponse = jsonResponse;
//		return (jsonResponse, progress);
//	}

//}

//public static class UnityWebRequestExtensions
//{
//	public static UnityWebRequestAwaiter GetAwaiter(this UnityWebRequestAsyncOperation asyncOp)
//	{
//		return new UnityWebRequestAwaiter(asyncOp);
//	}
//}

//public class UnityWebRequestAwaiter : INotifyCompletion
//{
//	private UnityWebRequestAsyncOperation _asyncOp;
//	private System.Action _continuation;

//	public UnityWebRequestAwaiter(UnityWebRequestAsyncOperation asyncOp)
//	{
//		_asyncOp = asyncOp;
//		asyncOp.completed += OnRequestCompleted;
//	}

//	public bool IsCompleted => _asyncOp.isDone;

//	public void OnCompleted(System.Action continuation)
//	{
//		_continuation = continuation;
//	}

//	public void GetResult() { }

//	private void OnRequestCompleted(AsyncOperation op)
//	{
//		_continuation?.Invoke();
//	}
//}

//public static class TaskExtensions
//{
//	public static async Task Until(this UnityWebRequestAsyncOperation operation, Func<bool> predicate)
//	{
//		while (!operation.isDone)
//		{
//			if (predicate.Invoke())
//				break;

//			await Task.Yield();
//		}
//	}
//}
